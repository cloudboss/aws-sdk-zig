const AIDetails = @import("ai_details.zig").AIDetails;

/// Additional details about a resource that are specific to its category. For
/// AI/ML resources and their host resources, this structure contains
/// `AIDetails`.
pub const ResourceInfo = struct {
    /// Details that are specific to self-hosted AI resources and their host
    /// resources.
    ai_details: ?AIDetails = null,

    pub const json_field_names = .{
        .ai_details = "AIDetails",
    };
};
