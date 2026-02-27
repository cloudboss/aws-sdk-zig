const PolicyAttachment = @import("policy_attachment.zig").PolicyAttachment;

/// Used when a regular object exists in a Directory and you want to find
/// all of the policies that are associated with that object and the parent to
/// that
/// object.
pub const PolicyToPath = struct {
    /// The path that is referenced from the root.
    path: ?[]const u8,

    /// List of policy objects.
    policies: ?[]const PolicyAttachment,

    pub const json_field_names = .{
        .path = "Path",
        .policies = "Policies",
    };
};
