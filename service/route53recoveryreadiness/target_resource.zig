const NLBResource = @import("nlb_resource.zig").NLBResource;
const R53ResourceRecord = @import("r53_resource_record.zig").R53ResourceRecord;

/// The target resource that the Route 53 record points to.
pub const TargetResource = struct {
    /// The Network Load Balancer Resource.
    nlb_resource: ?NLBResource = null,

    /// The Route 53 resource.
    r53_resource: ?R53ResourceRecord = null,

    pub const json_field_names = .{
        .nlb_resource = "NLBResource",
        .r53_resource = "R53Resource",
    };
};
