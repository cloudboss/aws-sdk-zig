/// A suggested action that shows a location on a map when tapped by the
/// recipient.
pub const RcsShowLocationAction = struct {
    /// An optional label for the location pin. Maximum 100 characters.
    label: ?[]const u8 = null,

    /// The latitude of the location. Valid values are -90 to 90.
    latitude: f64,

    /// The longitude of the location. Valid values are -180 to 180.
    longitude: f64,

    /// The postback data sent to your webhook when the user taps this action.
    /// Maximum 2048 characters.
    postback_data: []const u8,

    /// The display text of the action. Maximum 25 characters.
    text: []const u8,

    pub const json_field_names = .{
        .label = "Label",
        .latitude = "Latitude",
        .longitude = "Longitude",
        .postback_data = "PostbackData",
        .text = "Text",
    };
};
