const OcsfIpField = @import("ocsf_ip_field.zig").OcsfIpField;
const IpFilter = @import("ip_filter.zig").IpFilter;

/// The structure for filtering findings based on IP address attributes.
pub const OcsfIpFilter = struct {
    /// The name of the IP address field to filter on.
    field_name: ?OcsfIpField,

    filter: ?IpFilter,

    pub const json_field_names = .{
        .field_name = "FieldName",
        .filter = "Filter",
    };
};
