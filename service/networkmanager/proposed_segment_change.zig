const Tag = @import("tag.zig").Tag;

/// Describes a proposed segment change. In some cases, the segment change must
/// first be evaluated and accepted.
pub const ProposedSegmentChange = struct {
    /// The rule number in the policy document that applies to this change.
    attachment_policy_rule_number: ?i32,

    /// The name of the segment to change.
    segment_name: ?[]const u8,

    /// The list of key-value tags that changed for the segment.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .attachment_policy_rule_number = "AttachmentPolicyRuleNumber",
        .segment_name = "SegmentName",
        .tags = "Tags",
    };
};
