const std = @import("std");

/// The name of a field that you can use to filter app search results. Valid
/// values are:
///
/// * `APP_ID` – The unique identifier of the app.
///
/// * `APP_NAME` – The display name of the app.
///
/// * `DIRECT_QUICKSIGHT_SOLE_OWNER` – An Amazon QuickSight user or group that
///   is the sole direct owner.
///
/// * `DIRECT_QUICKSIGHT_OWNER` – An Amazon QuickSight user or group with direct
///   owner permissions.
///
/// * `DIRECT_QUICKSIGHT_VIEWER_OR_OWNER` – An Amazon QuickSight user or group
///   with direct viewer or owner permissions.
pub const SearchAppsFilterName = enum {
    app_id,
    app_name,
    direct_quicksight_sole_owner,
    direct_quicksight_owner,
    direct_quicksight_viewer_or_owner,

    pub const json_field_names = .{
        .app_id = "APP_ID",
        .app_name = "APP_NAME",
        .direct_quicksight_sole_owner = "DIRECT_QUICKSIGHT_SOLE_OWNER",
        .direct_quicksight_owner = "DIRECT_QUICKSIGHT_OWNER",
        .direct_quicksight_viewer_or_owner = "DIRECT_QUICKSIGHT_VIEWER_OR_OWNER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .app_id => "APP_ID",
            .app_name => "APP_NAME",
            .direct_quicksight_sole_owner => "DIRECT_QUICKSIGHT_SOLE_OWNER",
            .direct_quicksight_owner => "DIRECT_QUICKSIGHT_OWNER",
            .direct_quicksight_viewer_or_owner => "DIRECT_QUICKSIGHT_VIEWER_OR_OWNER",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
