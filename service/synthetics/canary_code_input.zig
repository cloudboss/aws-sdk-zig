const Dependency = @import("dependency.zig").Dependency;

/// Use this structure to input your script code for the canary. This structure
/// contains the
/// Lambda handler with the location where the canary should start running the
/// script. If the
/// script is stored in an Amazon S3 bucket, the bucket name, key, and version
/// are also included. If
/// the script was passed into the canary directly, the script code is contained
/// in the value
/// of `Zipfile`.
///
/// If you are uploading your canary scripts with an Amazon S3 bucket, your zip
/// file should include your
/// script in a certain folder structure.
///
/// * For Node.js canaries, the folder structure must be
///   `nodejs/node_modules/*myCanaryFilename.js*
/// `
/// For more information, see [Packaging your Node.js canary
/// files](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Synthetics_Canaries_WritingCanary_Nodejs.html#CloudWatch_Synthetics_Canaries_package)
///
/// * For Python canaries, the folder structure must be
///   `python/*myCanaryFilename.py*
/// ` or `python/*myFolder/myCanaryFilename.py*
/// `
/// For more information, see [Packaging your Python canary
/// files](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Synthetics_Canaries_WritingCanary_Python.html#CloudWatch_Synthetics_Canaries_WritingCanary_Python_package)
pub const CanaryCodeInput = struct {
    /// `BlueprintTypes` is a list of templates that enable simplified canary
    /// creation. You can create canaries for common monitoring scenarios by
    /// providing only a JSON configuration file instead of writing custom scripts.
    /// The only supported value is `multi-checks`.
    ///
    /// Multi-checks monitors HTTP/DNS/SSL/TCP endpoints with built-in
    /// authentication schemes (Basic, API Key, OAuth, SigV4) and assertion
    /// capabilities. When you specify `BlueprintTypes`, the Handler field cannot be
    /// specified since the blueprint provides a pre-defined entry point.
    ///
    /// `BlueprintTypes` is supported only on canaries for syn-nodejs-3.0 runtime or
    /// later.
    blueprint_types: ?[]const []const u8,

    /// A list of dependencies that should be used for running this canary. Specify
    /// the dependencies as a key-value pair, where the key is the type of
    /// dependency and the value is the dependency reference.
    dependencies: ?[]const Dependency,

    /// The entry point to use for the source code when running the canary. For
    /// canaries that use the
    /// `syn-python-selenium-1.0` runtime
    /// or a `syn-nodejs.puppeteer` runtime earlier than `syn-nodejs.puppeteer-3.4`,
    /// the handler must be specified as `
    /// *fileName*.handler`. For
    /// `syn-python-selenium-1.1`, `syn-nodejs.puppeteer-3.4`, and later runtimes,
    /// the handler can be specified as
    /// `
    /// *fileName*.*functionName*
    /// `, or
    /// you can specify a folder where canary scripts reside as
    /// `
    /// *folder*/*fileName*.*functionName*
    /// `.
    ///
    /// This field is required when you don't specify `BlueprintTypes` and is not
    /// allowed when you specify `BlueprintTypes`.
    handler: []const u8 = "",

    /// If your canary script is located in Amazon S3, specify the bucket name here.
    /// Do not include `s3://` as the
    /// start of the bucket name.
    s3_bucket: ?[]const u8,

    /// The Amazon S3 key of your script. For more information, see [Working with
    /// Amazon S3
    /// Objects](https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingObjects.html).
    s3_key: ?[]const u8,

    /// The Amazon S3 version ID of your script.
    s3_version: ?[]const u8,

    /// If you input your canary script directly into the canary instead of
    /// referring to an Amazon S3
    /// location, the value of this parameter is the base64-encoded contents of the
    /// .zip file that
    /// contains the script. It must be smaller than 225 Kb.
    ///
    /// For large canary scripts, we recommend that you use an Amazon S3 location
    /// instead of inputting it
    /// directly with this parameter.
    zip_file: ?[]const u8,

    pub const json_field_names = .{
        .blueprint_types = "BlueprintTypes",
        .dependencies = "Dependencies",
        .handler = "Handler",
        .s3_bucket = "S3Bucket",
        .s3_key = "S3Key",
        .s3_version = "S3Version",
        .zip_file = "ZipFile",
    };
};
