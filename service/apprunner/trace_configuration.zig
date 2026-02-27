const TracingVendor = @import("tracing_vendor.zig").TracingVendor;

/// Describes the configuration of the tracing feature within an App Runner
/// observability configuration.
pub const TraceConfiguration = struct {
    /// The implementation provider chosen for tracing App Runner services.
    vendor: TracingVendor,

    pub const json_field_names = .{
        .vendor = "Vendor",
    };
};
