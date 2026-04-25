const S3Location = @import("s3_location.zig").S3Location;

/// Properties describing a Realtime script.
///
/// **Related actions**
///
/// [All APIs by
/// task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
pub const Script = struct {
    /// A time stamp indicating when this data object was created. Format is a
    /// number expressed in Unix time as milliseconds (for example
    /// `"1469498468.057"`).
    creation_time: ?i64 = null,

    /// A descriptive label that is associated with a script. Script names do not
    /// need to be unique.
    name: ?[]const u8 = null,

    /// The Node.js version used for execution of your Realtime script. The valid
    /// values are
    /// `10.x | 24.x`. By default, `NodeJsVersion` is `10.x`.
    /// This value cannot be updated later.
    ///
    /// Node.js 10 will reach end of support on September 30, 2026. See more details
    /// in the [Node.js 10 FAQs](http://aws.amazon.com/gamelift/faq/nodejs10/). For
    /// migration guidance,
    /// see [
    /// Migrating from Node.js 10 to
    /// 24](https://docs.aws.amazon.com/gamelift/latest/realtimeguide/realtime-script.html#realtime-script-nodejs-migration).
    node_js_version: ?[]const u8 = null,

    /// The Amazon Resource Name
    /// ([ARN](https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html))
    /// that is assigned to a Amazon GameLift Servers script resource and uniquely
    /// identifies it. ARNs are unique across all Regions. In a GameLift script ARN,
    /// the resource ID matches the
    /// *ScriptId* value.
    script_arn: ?[]const u8 = null,

    /// A unique identifier for the Realtime script
    script_id: ?[]const u8 = null,

    /// The file size of the uploaded Realtime script, expressed in bytes. When
    /// files are
    /// uploaded from an S3 location, this value remains at "0".
    size_on_disk: ?i64 = null,

    /// The location of the Amazon S3 bucket where a zipped file containing your
    /// Realtime scripts is
    /// stored. The storage location must specify the Amazon S3 bucket name, the zip
    /// file name (the
    /// "key"), and a role ARN that allows Amazon GameLift Servers to access the
    /// Amazon S3 storage location. The S3
    /// bucket must be in the same Region where you want to create a new script. By
    /// default,
    /// Amazon GameLift Servers uploads the latest version of the zip file; if you
    /// have S3 object versioning
    /// turned on, you can use the `ObjectVersion` parameter to specify an earlier
    /// version.
    storage_location: ?S3Location = null,

    /// Version information that is associated with a build or script. Version
    /// strings do not need to be unique.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .name = "Name",
        .node_js_version = "NodeJsVersion",
        .script_arn = "ScriptArn",
        .script_id = "ScriptId",
        .size_on_disk = "SizeOnDisk",
        .storage_location = "StorageLocation",
        .version = "Version",
    };
};
