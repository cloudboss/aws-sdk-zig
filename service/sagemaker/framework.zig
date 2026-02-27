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
};
