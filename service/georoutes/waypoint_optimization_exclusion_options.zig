/// Specifies strict exclusion options for the route calculation. This setting
/// mandates that the router will avoid any routes that include the specified
/// options, rather than merely attempting to minimize them.
pub const WaypointOptimizationExclusionOptions = struct {
    /// List of countries to be avoided defined by two-letter or three-letter
    /// country codes.
    countries: []const []const u8,

    pub const json_field_names = .{
        .countries = "Countries",
    };
};
