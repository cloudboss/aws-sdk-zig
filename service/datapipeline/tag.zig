/// Tags are key/value pairs defined by a user and associated with a pipeline to
/// control access. AWS Data Pipeline allows you to associate ten tags per
/// pipeline.
/// For more information, see [Controlling User Access to
/// Pipelines](http://docs.aws.amazon.com/datapipeline/latest/DeveloperGuide/dp-control-access.html) in the *AWS Data Pipeline Developer Guide*.
pub const Tag = struct {
    /// The key name of a tag defined by a user.
    /// For more information, see [Controlling User Access to
    /// Pipelines](http://docs.aws.amazon.com/datapipeline/latest/DeveloperGuide/dp-control-access.html) in the *AWS Data Pipeline Developer Guide*.
    key: []const u8,

    /// The optional value portion of a tag defined by a user.
    /// For more information, see [Controlling User Access to
    /// Pipelines](http://docs.aws.amazon.com/datapipeline/latest/DeveloperGuide/dp-control-access.html) in the *AWS Data Pipeline Developer Guide*.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
