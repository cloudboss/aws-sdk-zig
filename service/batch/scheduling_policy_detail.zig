const aws = @import("aws");

const FairsharePolicy = @import("fairshare_policy.zig").FairsharePolicy;

/// An object that represents a scheduling policy.
pub const SchedulingPolicyDetail = struct {
    /// The Amazon Resource Name (ARN) of the scheduling policy. An example is
    /// `arn:*aws*:batch:*us-east-1*:*123456789012*:scheduling-policy/*HighPriority*
    /// `.
    arn: []const u8,

    /// The fair-share scheduling policy details.
    fairshare_policy: ?FairsharePolicy = null,

    /// The name of the fair-share scheduling policy.
    name: []const u8,

    /// The tags that you apply to the fair-share scheduling policy to categorize
    /// and organize your resources.
    /// Each tag consists of a key and an optional value. For more information, see
    /// [Tagging Amazon Web Services
    /// resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    /// in
    /// *Amazon Web Services General Reference*.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .fairshare_policy = "fairsharePolicy",
        .name = "name",
        .tags = "tags",
    };
};
