const GeocodePreferenceValue = @import("geocode_preference_value.zig").GeocodePreferenceValue;
const GeocoderHierarchy = @import("geocoder_hierarchy.zig").GeocoderHierarchy;

/// The geocode preference.
pub const GeocodePreference = struct {
    /// The preference definition for the geocode preference.
    preference: GeocodePreferenceValue,

    /// The unique request key for the geocode preference.
    request_key: GeocoderHierarchy,

    pub const json_field_names = .{
        .preference = "Preference",
        .request_key = "RequestKey",
    };
};
