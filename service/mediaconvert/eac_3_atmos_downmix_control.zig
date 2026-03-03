const std = @import("std");

/// Specify whether MediaConvert should use any downmix metadata from your input
/// file. Keep the default value, Custom to provide downmix values in your job
/// settings. Choose Follow source to use the metadata from your input. Related
/// settings--Use these settings to specify your downmix values: Left only/Right
/// only surround, Left total/Right total surround, Left total/Right total
/// center, Left only/Right only center, and Stereo downmix. When you keep
/// Custom for Downmix control and you don't specify values for the related
/// settings, MediaConvert uses default values for those settings.
pub const Eac3AtmosDownmixControl = enum {
    specified,
    initialize_from_source,

    pub const json_field_names = .{
        .specified = "SPECIFIED",
        .initialize_from_source = "INITIALIZE_FROM_SOURCE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .specified => "SPECIFIED",
            .initialize_from_source => "INITIALIZE_FROM_SOURCE",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
