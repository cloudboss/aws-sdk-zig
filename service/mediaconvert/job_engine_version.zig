/// Use Job engine versions to run jobs for your production workflow on one
/// version, while you test and validate the latest version. Job engine versions
/// are in a YYYY-MM-DD format.
pub const JobEngineVersion = struct {
    /// The date that this Job engine version expires. Requests to create jobs with
    /// an expired version result in a regular job, as if no specific Job engine
    /// version was requested.
    expiration_date: ?i64,

    /// Use Job engine versions to run jobs for your production workflow on one
    /// version, while you test and validate the latest version. Job engine versions
    /// represent periodically grouped MediaConvert releases with new features,
    /// updates, improvements, and fixes. Job engine versions are in a YYYY-MM-DD
    /// format. Note that the Job engine version feature is not publicly available
    /// at this time. To request access, contact AWS support.
    version: ?[]const u8,

    pub const json_field_names = .{
        .expiration_date = "ExpirationDate",
        .version = "Version",
    };
};
