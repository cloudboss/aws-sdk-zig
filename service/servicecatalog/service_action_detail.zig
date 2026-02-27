const aws = @import("aws");

const ServiceActionSummary = @import("service_action_summary.zig").ServiceActionSummary;

/// An object containing detailed information about the self-service action.
pub const ServiceActionDetail = struct {
    /// A map that defines the self-service action.
    definition: ?[]const aws.map.StringMapEntry,

    /// Summary information about the self-service action.
    service_action_summary: ?ServiceActionSummary,

    pub const json_field_names = .{
        .definition = "Definition",
        .service_action_summary = "ServiceActionSummary",
    };
};
