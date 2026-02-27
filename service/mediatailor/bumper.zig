/// The configuration for bumpers. Bumpers are short audio or video clips that
/// play at the start or before the end of an ad break. To learn more about
/// bumpers, see
/// [Bumpers](https://docs.aws.amazon.com/mediatailor/latest/ug/bumpers.html).
pub const Bumper = struct {
    /// The URL for the end bumper asset.
    end_url: ?[]const u8,

    /// The URL for the start bumper asset.
    start_url: ?[]const u8,

    pub const json_field_names = .{
        .end_url = "EndUrl",
        .start_url = "StartUrl",
    };
};
