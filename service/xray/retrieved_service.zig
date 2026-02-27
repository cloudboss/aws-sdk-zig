const GraphLink = @import("graph_link.zig").GraphLink;
const Service = @import("service.zig").Service;

/// Retrieved information about an application that processed requests, users
/// that made requests, or downstream services, resources, and applications that
/// an application used.
pub const RetrievedService = struct {
    /// Relation between two 2 services.
    links: ?[]const GraphLink,

    service: ?Service,

    pub const json_field_names = .{
        .links = "Links",
        .service = "Service",
    };
};
