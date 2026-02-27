/// Provides information about an Amazon Web Service that performed an action on
/// an affected resource.
pub const AwsService = struct {
    /// The name of the Amazon Web Service that performed the action.
    invoked_by: ?[]const u8,

    pub const json_field_names = .{
        .invoked_by = "invokedBy",
    };
};
