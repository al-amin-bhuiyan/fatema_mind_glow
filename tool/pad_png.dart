import 'dart:io';
import 'dart:math' as math;

import 'package:image/image.dart' as img;

/// Pads a PNG with transparent margins.
///
/// Usage:
///   dart run tool/pad_png.dart <input> <output> [paddingPercent]
///
/// paddingPercent defaults to 0.10 (10%).
Future<void> main(List<String> args) async {
  if (args.length < 2) {
    stderr.writeln(
      'Usage: dart run tool/pad_png.dart <input> <output> [paddingPercent]',
    );
    exitCode = 64;
    return;
  }

  final inputPath = args[0];
  final outputPath = args[1];
  final paddingPercent = args.length >= 3
      ? double.tryParse(args[2]) ?? 0.10
      : 0.10;

  if (paddingPercent < 0 || paddingPercent > 0.5) {
    stderr.writeln('paddingPercent must be between 0 and 0.5');
    exitCode = 64;
    return;
  }

  final inputFile = File(inputPath);
  if (!await inputFile.exists()) {
    stderr.writeln('Input file not found: $inputPath');
    exitCode = 66;
    return;
  }

  final bytes = await inputFile.readAsBytes();
  final decoded = img.decodeImage(bytes);
  if (decoded == null) {
    stderr.writeln('Failed to decode image: $inputPath');
    exitCode = 65;
    return;
  }

  final w = decoded.width;
  final h = decoded.height;

  final padX = (w * paddingPercent).round();
  final padY = (h * paddingPercent).round();

  final outW = w + padX * 2;
  final outH = h + padY * 2;

  final canvas = img.Image(width: outW, height: outH);
  img.fill(canvas, color: img.ColorRgba8(0, 0, 0, 0));

  img.compositeImage(canvas, decoded, dstX: padX, dstY: padY);

  await File(outputPath).create(recursive: true);
  await File(outputPath).writeAsBytes(img.encodePng(canvas));

  stdout.writeln('Input:  $inputPath   (${w}x$h)');
  stdout.writeln('Output: $outputPath  (${outW}x$outH)');
  stdout.writeln('Padding: ${(paddingPercent * 100).toStringAsFixed(1)}%');
}
