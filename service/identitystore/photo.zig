/// Contains information about a user's photo. Users can have up to 3 photos,
/// with one designated as primary. Supports common image formats, including
/// jpg, jpeg, png, and gif.
pub const Photo = struct {
    /// A human-readable description of the photo for display purposes. This
    /// optional field provides context about the photo.
    display: ?[]const u8,

    /// Specifies whether this is the user's primary photo. Default value is
    /// `false`. Only one photo can be designated as primary per user.
    primary: bool = false,

    /// The type of photo. This field is optional and can be used to categorize
    /// different types of photos.
    @"type": ?[]const u8,

    /// The photo data or URL. Supported formats include jpg, jpeg, png, and gif.
    /// This field is required for all photo entries.
    value: []const u8,

    pub const json_field_names = .{
        .display = "Display",
        .primary = "Primary",
        .@"type" = "Type",
        .value = "Value",
    };
};
