const std = @import("std");

pub const Framework = enum {
    tensorflow,
    keras,
    mxnet,
    onnx,
    pytorch,
    xgboost,
    tflite,
    darknet,
    sklearn,

    pub const json_field_names = .{
        .tensorflow = "TENSORFLOW",
        .keras = "KERAS",
        .mxnet = "MXNET",
        .onnx = "ONNX",
        .pytorch = "PYTORCH",
        .xgboost = "XGBOOST",
        .tflite = "TFLITE",
        .darknet = "DARKNET",
        .sklearn = "SKLEARN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .tensorflow => "TENSORFLOW",
            .keras => "KERAS",
            .mxnet => "MXNET",
            .onnx => "ONNX",
            .pytorch => "PYTORCH",
            .xgboost => "XGBOOST",
            .tflite => "TFLITE",
            .darknet => "DARKNET",
            .sklearn => "SKLEARN",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
