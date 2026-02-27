/// A label that you can assign to a Amazon GameLift Servers resource.
///
/// **Learn more**
///
/// [Tagging Amazon Web Services
/// Resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
/// in the *Amazon Web Services General Reference*
///
/// [
/// Amazon Web Services Tagging
/// Strategies](http://aws.amazon.com/answers/account-management/aws-tagging-strategies/)
///
/// **Related actions**
///
/// [All APIs by
/// task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
pub const Tag = struct {
    /// The key for a developer-defined key value pair for tagging an Amazon Web
    /// Services resource.
    key: []const u8,

    /// The value for a developer-defined key value pair for tagging an Amazon Web
    /// Services resource.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
