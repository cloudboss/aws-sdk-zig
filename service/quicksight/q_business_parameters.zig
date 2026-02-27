/// The parameters that are required to connect to an Amazon Q Business data
/// source.
pub const QBusinessParameters = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Q Business application.
    application_arn: []const u8,

    pub const json_field_names = .{
        .application_arn = "ApplicationArn",
    };
};
