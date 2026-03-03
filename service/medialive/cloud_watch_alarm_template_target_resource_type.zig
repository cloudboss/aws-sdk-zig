const std = @import("std");

/// The resource type this template should dynamically generate cloudwatch
/// metric alarms for.
pub const CloudWatchAlarmTemplateTargetResourceType = enum {
    cloudfront_distribution,
    medialive_multiplex,
    medialive_channel,
    medialive_input_device,
    mediapackage_channel,
    mediapackage_origin_endpoint,
    mediaconnect_flow,
    s3_bucket,
    mediatailor_playback_configuration,

    pub const json_field_names = .{
        .cloudfront_distribution = "CLOUDFRONT_DISTRIBUTION",
        .medialive_multiplex = "MEDIALIVE_MULTIPLEX",
        .medialive_channel = "MEDIALIVE_CHANNEL",
        .medialive_input_device = "MEDIALIVE_INPUT_DEVICE",
        .mediapackage_channel = "MEDIAPACKAGE_CHANNEL",
        .mediapackage_origin_endpoint = "MEDIAPACKAGE_ORIGIN_ENDPOINT",
        .mediaconnect_flow = "MEDIACONNECT_FLOW",
        .s3_bucket = "S3_BUCKET",
        .mediatailor_playback_configuration = "MEDIATAILOR_PLAYBACK_CONFIGURATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cloudfront_distribution => "CLOUDFRONT_DISTRIBUTION",
            .medialive_multiplex => "MEDIALIVE_MULTIPLEX",
            .medialive_channel => "MEDIALIVE_CHANNEL",
            .medialive_input_device => "MEDIALIVE_INPUT_DEVICE",
            .mediapackage_channel => "MEDIAPACKAGE_CHANNEL",
            .mediapackage_origin_endpoint => "MEDIAPACKAGE_ORIGIN_ENDPOINT",
            .mediaconnect_flow => "MEDIACONNECT_FLOW",
            .s3_bucket => "S3_BUCKET",
            .mediatailor_playback_configuration => "MEDIATAILOR_PLAYBACK_CONFIGURATION",
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
