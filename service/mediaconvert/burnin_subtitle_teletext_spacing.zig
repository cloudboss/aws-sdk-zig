/// Specify whether the text spacing in your captions is set by the captions
/// grid, or varies depending on letter width. Choose fixed grid to conform to
/// the spacing specified in the captions file more accurately. Choose
/// proportional to make the text easier to read for closed captions.
pub const BurninSubtitleTeletextSpacing = enum {
    fixed_grid,
    proportional,
    auto,

    pub const json_field_names = .{
        .fixed_grid = "FIXED_GRID",
        .proportional = "PROPORTIONAL",
        .auto = "AUTO",
    };
};
