const TargetDevice = @import("target_device.zig").TargetDevice;
const TargetPlatform = @import("target_platform.zig").TargetPlatform;

/// Contains information about the output location for the compiled model and
/// the target device that the model runs on. `TargetDevice` and
/// `TargetPlatform` are mutually exclusive, so you need to choose one between
/// the two to specify your target device or platform. If you cannot find your
/// device you want to use from the `TargetDevice` list, use `TargetPlatform` to
/// describe the platform of your edge device and `CompilerOptions` if there are
/// specific settings that are required or recommended to use for particular
/// TargetPlatform.
pub const OutputConfig = struct {
    /// Specifies additional parameters for compiler options in JSON format. The
    /// compiler options are `TargetPlatform` specific. It is required for NVIDIA
    /// accelerators and highly recommended for CPU compilations. For any other
    /// cases, it is optional to specify `CompilerOptions.`
    ///
    /// * `DTYPE`: Specifies the data type for the input. When compiling for `ml_*`
    ///   (except for `ml_inf`) instances using PyTorch framework, provide the data
    ///   type (dtype) of the model's input. `"float32"` is used if `"DTYPE"` is not
    ///   specified. Options for data type are:
    ///
    /// * float32: Use either `"float"` or `"float32"`.
    /// * int64: Use either `"int64"` or `"long"`.
    ///
    /// For example, `{"dtype" : "float32"}`.
    /// * `CPU`: Compilation for CPU supports the following compiler options.
    ///
    /// * `mcpu`: CPU micro-architecture. For example, `{'mcpu': 'skylake-avx512'}`
    /// * `mattr`: CPU flags. For example, `{'mattr': ['+neon', '+vfpv4']}`
    ///
    /// * `ARM`: Details of ARM CPU compilations.
    ///
    /// * `NEON`: NEON is an implementation of the Advanced SIMD extension used in
    ///   ARMv7 processors.
    ///
    /// For example, add `{'mattr': ['+neon']}` to the compiler options if compiling
    /// for ARM 32-bit platform with the NEON support.
    ///
    /// * `NVIDIA`: Compilation for NVIDIA GPU supports the following compiler
    ///   options.
    ///
    /// * `gpu_code`: Specifies the targeted architecture.
    /// * `trt-ver`: Specifies the TensorRT versions in x.y.z. format.
    /// * `cuda-ver`: Specifies the CUDA version in x.y format.
    ///
    /// For example, `{'gpu-code': 'sm_72', 'trt-ver': '6.0.1', 'cuda-ver': '10.1'}`
    /// * `ANDROID`: Compilation for the Android OS supports the following compiler
    ///   options:
    ///
    /// * `ANDROID_PLATFORM`: Specifies the Android API levels. Available levels
    ///   range from 21 to 29. For example, `{'ANDROID_PLATFORM': 28}`.
    /// * `mattr`: Add `{'mattr': ['+neon']}` to compiler options if compiling for
    ///   ARM 32-bit platform with NEON support.
    ///
    /// * `INFERENTIA`: Compilation for target ml_inf1 uses compiler options passed
    ///   in as a JSON string. For example, `"CompilerOptions": "\"--verbose 1
    ///   --num-neuroncores 2 -O2\""`.
    ///
    /// For information about supported compiler options, see [ Neuron Compiler CLI
    /// Reference
    /// Guide](https://awsdocs-neuron.readthedocs-hosted.com/en/latest/compiler/neuronx-cc/api-reference-guide/neuron-compiler-cli-reference-guide.html).
    /// * `CoreML`: Compilation for the CoreML
    ///   [OutputConfig](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_OutputConfig.html) `TargetDevice` supports the following compiler options:
    ///
    /// * `class_labels`: Specifies the classification labels file name inside input
    ///   tar.gz file. For example, `{"class_labels": "imagenet_labels_1000.txt"}`.
    ///   Labels inside the txt file should be separated by newlines.
    compiler_options: ?[]const u8,

    /// The Amazon Web Services Key Management Service key (Amazon Web Services KMS)
    /// that Amazon SageMaker AI uses to encrypt your output models with Amazon S3
    /// server-side encryption after compilation job. If you don't provide a KMS key
    /// ID, Amazon SageMaker AI uses the default KMS key for Amazon S3 for your
    /// role's account. For more information, see [KMS-Managed Encryption
    /// Keys](https://docs.aws.amazon.com/AmazonS3/latest/userguide/UsingKMSEncryption.html) in the *Amazon Simple Storage Service Developer Guide.*
    ///
    /// The KmsKeyId can be any of the following formats:
    ///
    /// * Key ID: `1234abcd-12ab-34cd-56ef-1234567890ab`
    /// * Key ARN:
    ///   `arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab`
    /// * Alias name: `alias/ExampleAlias`
    /// * Alias name ARN: `arn:aws:kms:us-west-2:111122223333:alias/ExampleAlias`
    kms_key_id: ?[]const u8,

    /// Identifies the S3 bucket where you want Amazon SageMaker AI to store the
    /// model artifacts. For example, `s3://bucket-name/key-name-prefix`.
    s3_output_location: []const u8,

    /// Identifies the target device or the machine learning instance that you want
    /// to run your model on after the compilation has completed. Alternatively, you
    /// can specify OS, architecture, and accelerator using
    /// [TargetPlatform](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_TargetPlatform.html) fields. It can be used instead of `TargetPlatform`.
    ///
    /// Currently `ml_trn1` is available only in US East (N. Virginia) Region, and
    /// `ml_inf2` is available only in US East (Ohio) Region.
    target_device: ?TargetDevice,

    /// Contains information about a target platform that you want your model to run
    /// on, such as OS, architecture, and accelerators. It is an alternative of
    /// `TargetDevice`.
    ///
    /// The following examples show how to configure the `TargetPlatform` and
    /// `CompilerOptions` JSON strings for popular target platforms:
    ///
    /// * Raspberry Pi 3 Model B+
    ///
    /// `"TargetPlatform": {"Os": "LINUX", "Arch": "ARM_EABIHF"},`
    ///
    /// ` "CompilerOptions": {'mattr': ['+neon']}`
    /// * Jetson TX2
    ///
    /// `"TargetPlatform": {"Os": "LINUX", "Arch": "ARM64", "Accelerator":
    /// "NVIDIA"},`
    ///
    /// ` "CompilerOptions": {'gpu-code': 'sm_62', 'trt-ver': '6.0.1', 'cuda-ver':
    /// '10.0'}`
    /// * EC2 m5.2xlarge instance OS
    ///
    /// `"TargetPlatform": {"Os": "LINUX", "Arch": "X86_64", "Accelerator":
    /// "NVIDIA"},`
    ///
    /// ` "CompilerOptions": {'mcpu': 'skylake-avx512'}`
    /// * RK3399
    ///
    /// `"TargetPlatform": {"Os": "LINUX", "Arch": "ARM64", "Accelerator": "MALI"}`
    /// * ARMv7 phone (CPU)
    ///
    /// `"TargetPlatform": {"Os": "ANDROID", "Arch": "ARM_EABI"},`
    ///
    /// ` "CompilerOptions": {'ANDROID_PLATFORM': 25, 'mattr': ['+neon']}`
    /// * ARMv8 phone (CPU)
    ///
    /// `"TargetPlatform": {"Os": "ANDROID", "Arch": "ARM64"},`
    ///
    /// ` "CompilerOptions": {'ANDROID_PLATFORM': 29}`
    target_platform: ?TargetPlatform,

    pub const json_field_names = .{
        .compiler_options = "CompilerOptions",
        .kms_key_id = "KmsKeyId",
        .s3_output_location = "S3OutputLocation",
        .target_device = "TargetDevice",
        .target_platform = "TargetPlatform",
    };
};
