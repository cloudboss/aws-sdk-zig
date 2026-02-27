/// Describes the S3 location.
pub const S3Location = struct {
    /// The S3 bucket of the S3 object.
    s3_bucket: []const u8,

    /// The S3 key of the S3 object.
    ///
    /// This is required when used for the following:
    ///
    /// * IconS3Location (Actions: CreateApplication and UpdateApplication)
    ///
    /// * SessionScriptS3Location (Actions: CreateFleet and UpdateFleet)
    ///
    /// * ScriptDetails (Actions: CreateAppBlock)
    ///
    /// * SourceS3Location when creating an app block with `CUSTOM` PackagingType
    ///   (Actions:
    /// CreateAppBlock)
    ///
    /// * SourceS3Location when creating an app block with `APPSTREAM2`
    ///   PackagingType, and
    /// using an existing application package (VHD file). In this case,
    /// `S3Key` refers to the VHD file. If a new application package is
    /// required, then `S3Key` is not required. (Actions:
    /// CreateAppBlock)
    s3_key: ?[]const u8,

    pub const json_field_names = .{
        .s3_bucket = "S3Bucket",
        .s3_key = "S3Key",
    };
};
