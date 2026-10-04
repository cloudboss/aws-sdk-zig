const WiFiCellular = @import("wi_fi_cellular.zig").WiFiCellular;

/// Optional configuration for customizing position estimates, including
/// parameters
/// that affect the accuracy and uncertainty of WiFi and cellular-based location
/// estimates.
pub const AdvancedConfiguration = struct {
    /// Configuration for WiFi and cellular-based location estimate payloads
    /// resolved
    /// by HERE's solvers.
    wi_fi_cellular: ?WiFiCellular = null,

    pub const json_field_names = .{
        .wi_fi_cellular = "WiFiCellular",
    };
};
