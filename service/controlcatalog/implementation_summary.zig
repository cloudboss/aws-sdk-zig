/// A summary of how the control is implemented, including the Amazon Web
/// Services service that enforces the control and its service-specific
/// identifier. For example, the value of this field could indicate that the
/// control is implemented as an Amazon Web Services Config Rule or an Amazon
/// Web Services Security Hub control.
pub const ImplementationSummary = struct {
    /// The identifier originally assigned by the Amazon Web Services service that
    /// implements the control. For example, `CODEPIPELINE_DEPLOYMENT_COUNT_CHECK`.
    identifier: ?[]const u8 = null,

    /// A string that represents the Amazon Web Services service that implements
    /// this control. For example, a value of `AWS::Config::ConfigRule` indicates
    /// that the control is implemented by Amazon Web Services Config, and
    /// `AWS::SecurityHub::SecurityControl` indicates implementation by Amazon Web
    /// Services Security Hub.
    @"type": []const u8,

    pub const json_field_names = .{
        .identifier = "Identifier",
        .@"type" = "Type",
    };
};
