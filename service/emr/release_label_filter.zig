/// The release label filters by application or version prefix.
pub const ReleaseLabelFilter = struct {
    /// Optional release label application filter. For example, `spark@2.1.0`.
    application: ?[]const u8 = null,

    /// Optional release label version prefix filter. For example, `emr-5`.
    prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .application = "Application",
        .prefix = "Prefix",
    };
};
