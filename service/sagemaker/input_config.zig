const Framework = @import("framework.zig").Framework;

/// Contains information about the location of input model artifacts, the name
/// and shape of the expected data inputs, and the framework in which the model
/// was trained.
pub const InputConfig = struct {
    /// Specifies the name and shape of the expected data inputs for your trained
    /// model with a JSON dictionary form. The data inputs are `Framework` specific.
    ///
    /// * `TensorFlow`: You must specify the name and shape (NHWC format) of the
    ///   expected data inputs using a dictionary format for your trained model. The
    ///   dictionary formats required for the console and CLI are different.
    ///
    /// * Examples for one input:
    ///
    /// * If using the console, `{"input":[1,1024,1024,3]}`
    /// * If using the CLI, `{\"input\":[1,1024,1024,3]}`
    ///
    /// * Examples for two inputs:
    ///
    /// * If using the console, `{"data1": [1,28,28,1], "data2":[1,28,28,1]}`
    /// * If using the CLI, `{\"data1\": [1,28,28,1], \"data2\":[1,28,28,1]}`
    ///
    /// * `KERAS`: You must specify the name and shape (NCHW format) of expected
    ///   data inputs using a dictionary format for your trained model. Note that
    ///   while Keras model artifacts should be uploaded in NHWC (channel-last)
    ///   format, `DataInputConfig` should be specified in NCHW (channel-first)
    ///   format. The dictionary formats required for the console and CLI are
    ///   different.
    ///
    /// * Examples for one input:
    ///
    /// * If using the console, `{"input_1":[1,3,224,224]}`
    /// * If using the CLI, `{\"input_1\":[1,3,224,224]}`
    ///
    /// * Examples for two inputs:
    ///
    /// * If using the console, `{"input_1": [1,3,224,224], "input_2":[1,3,224,224]}
    ///   `
    /// * If using the CLI, `{\"input_1\": [1,3,224,224],
    ///   \"input_2\":[1,3,224,224]}`
    ///
    /// * `MXNET/ONNX/DARKNET`: You must specify the name and shape (NCHW format) of
    ///   the expected data inputs in order using a dictionary format for your
    ///   trained model. The dictionary formats required for the console and CLI are
    ///   different.
    ///
    /// * Examples for one input:
    ///
    /// * If using the console, `{"data":[1,3,1024,1024]}`
    /// * If using the CLI, `{\"data\":[1,3,1024,1024]}`
    ///
    /// * Examples for two inputs:
    ///
    /// * If using the console, `{"var1": [1,1,28,28], "var2":[1,1,28,28]} `
    /// * If using the CLI, `{\"var1\": [1,1,28,28], \"var2\":[1,1,28,28]}`
    ///
    /// * `PyTorch`: You can either specify the name and shape (NCHW format) of
    ///   expected data inputs in order using a dictionary format for your trained
    ///   model or you can specify the shape only using a list format. The
    ///   dictionary formats required for the console and CLI are different. The
    ///   list formats for the console and CLI are the same.
    ///
    /// * Examples for one input in dictionary format:
    ///
    /// * If using the console, `{"input0":[1,3,224,224]}`
    /// * If using the CLI, `{\"input0\":[1,3,224,224]}`
    ///
    /// * Example for one input in list format: `[[1,3,224,224]]`
    /// * Examples for two inputs in dictionary format:
    ///
    /// * If using the console, `{"input0":[1,3,224,224], "input1":[1,3,224,224]}`
    /// * If using the CLI, `{\"input0\":[1,3,224,224], \"input1\":[1,3,224,224]} `
    ///
    /// * Example for two inputs in list format: `[[1,3,224,224], [1,3,224,224]]`
    ///
    /// * `XGBOOST`: input data name and shape are not needed.
    ///
    /// `DataInputConfig` supports the following parameters for `CoreML`
    /// `TargetDevice` (ML Model format):
    ///
    /// * `shape`: Input shape, for example `{"input_1": {"shape": [1,224,224,3]}}`.
    ///   In addition to static input shapes, CoreML converter supports Flexible
    ///   input shapes:
    ///
    /// * Range Dimension. You can use the Range Dimension feature if you know the
    ///   input shape will be within some specific interval in that dimension, for
    ///   example: `{"input_1": {"shape": ["1..10", 224, 224, 3]}}`
    /// * Enumerated shapes. Sometimes, the models are trained to work only on a
    ///   select set of inputs. You can enumerate all supported input shapes, for
    ///   example: `{"input_1": {"shape": [[1, 224, 224, 3], [1, 160, 160, 3]]}}`
    ///
    /// * `default_shape`: Default input shape. You can set a default shape during
    ///   conversion for both Range Dimension and Enumerated Shapes. For example
    ///   `{"input_1": {"shape": ["1..10", 224, 224, 3], "default_shape": [1, 224,
    ///   224, 3]}}`
    /// * `type`: Input type. Allowed values: `Image` and `Tensor`. By default, the
    ///   converter generates an ML Model with inputs of type Tensor (MultiArray).
    ///   User can set input type to be Image. Image input type requires additional
    ///   input parameters such as `bias` and `scale`.
    /// * `bias`: If the input type is an Image, you need to provide the bias
    ///   vector.
    /// * `scale`: If the input type is an Image, you need to provide a scale
    ///   factor.
    ///
    /// CoreML `ClassifierConfig` parameters can be specified using
    /// [OutputConfig](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_OutputConfig.html) `CompilerOptions`. CoreML converter supports Tensorflow and PyTorch models. CoreML conversion examples:
    ///
    /// * Tensor type input:
    ///
    /// * `"DataInputConfig": {"input_1": {"shape": [[1,224,224,3], [1,160,160,3]],
    ///   "default_shape": [1,224,224,3]}}`
    ///
    /// * Tensor type input without input name (PyTorch):
    ///
    /// * `"DataInputConfig": [{"shape": [[1,3,224,224], [1,3,160,160]],
    ///   "default_shape": [1,3,224,224]}]`
    ///
    /// * Image type input:
    ///
    /// * `"DataInputConfig": {"input_1": {"shape": [[1,224,224,3], [1,160,160,3]],
    ///   "default_shape": [1,224,224,3], "type": "Image", "bias": [-1,-1,-1],
    ///   "scale": 0.007843137255}}`
    /// * `"CompilerOptions": {"class_labels": "imagenet_labels_1000.txt"}`
    ///
    /// * Image type input without input name (PyTorch):
    ///
    /// * `"DataInputConfig": [{"shape": [[1,3,224,224], [1,3,160,160]],
    ///   "default_shape": [1,3,224,224], "type": "Image", "bias": [-1,-1,-1],
    ///   "scale": 0.007843137255}]`
    /// * `"CompilerOptions": {"class_labels": "imagenet_labels_1000.txt"}`
    ///
    /// Depending on the model format, `DataInputConfig` requires the following
    /// parameters for `ml_eia2`
    /// [OutputConfig:TargetDevice](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_OutputConfig.html#sagemaker-Type-OutputConfig-TargetDevice).
    ///
    /// * For TensorFlow models saved in the SavedModel format, specify the input
    ///   names from `signature_def_key` and the input model shapes for
    ///   `DataInputConfig`. Specify the `signature_def_key` in [
    ///   `OutputConfig:CompilerOptions`
    ///   ](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_OutputConfig.html#sagemaker-Type-OutputConfig-CompilerOptions) if the model does not use TensorFlow's default signature def key. For example:
    ///
    /// * `"DataInputConfig": {"inputs": [1, 224, 224, 3]}`
    /// * `"CompilerOptions": {"signature_def_key": "serving_custom"}`
    ///
    /// * For TensorFlow models saved as a frozen graph, specify the input tensor
    ///   names and shapes in `DataInputConfig` and the output tensor names for
    ///   `output_names` in [ `OutputConfig:CompilerOptions`
    ///   ](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_OutputConfig.html#sagemaker-Type-OutputConfig-CompilerOptions). For example:
    ///
    /// * `"DataInputConfig": {"input_tensor:0": [1, 224, 224, 3]}`
    /// * `"CompilerOptions": {"output_names": ["output_tensor:0"]}`
    data_input_config: ?[]const u8 = null,

    /// Identifies the framework in which the model was trained. For example:
    /// TENSORFLOW.
    framework: Framework,

    /// Specifies the framework version to use. This API field is only supported for
    /// the MXNet, PyTorch, TensorFlow and TensorFlow Lite frameworks.
    ///
    /// For information about framework versions supported for cloud targets and
    /// edge devices, see [Cloud Supported Instance Types and
    /// Frameworks](https://docs.aws.amazon.com/sagemaker/latest/dg/neo-supported-cloud.html) and [Edge Supported Frameworks](https://docs.aws.amazon.com/sagemaker/latest/dg/neo-supported-devices-edge-frameworks.html).
    framework_version: ?[]const u8 = null,

    /// The S3 path where the model artifacts, which result from model training, are
    /// stored. This path must point to a single gzip compressed tar archive
    /// (.tar.gz suffix).
    s3_uri: []const u8,

    pub const json_field_names = .{
        .data_input_config = "DataInputConfig",
        .framework = "Framework",
        .framework_version = "FrameworkVersion",
        .s3_uri = "S3Uri",
    };
};
