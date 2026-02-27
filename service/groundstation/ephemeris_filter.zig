const AzElEphemerisFilter = @import("az_el_ephemeris_filter.zig").AzElEphemerisFilter;

/// Filter for selecting contacts that use a specific ephemeris".
pub const EphemerisFilter = union(enum) {
    /// Filter for AzElEphemeris.
    az_el: ?AzElEphemerisFilter,

    pub const json_field_names = .{
        .az_el = "azEl",
    };
};
