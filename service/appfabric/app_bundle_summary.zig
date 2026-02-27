/// Contains a summary of an app bundle.
pub const AppBundleSummary = struct {
    /// The Amazon Resource Name (ARN) of the app bundle.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
    };
};
