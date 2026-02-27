/// The logging configuration that's defined for the image. Image Builder uses
/// the defined settings
/// to direct execution log output during image creation.
pub const ImageLoggingConfiguration = struct {
    /// The log group name that Image Builder uses for image creation. If not
    /// specified, the log group
    /// name defaults to `/aws/imagebuilder/image-name`.
    log_group_name: ?[]const u8,

    pub const json_field_names = .{
        .log_group_name = "logGroupName",
    };
};
