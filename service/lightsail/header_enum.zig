const std = @import("std");

pub const HeaderEnum = enum {
    accept,
    accept_charset,
    accept_datetime,
    accept_encoding,
    accept_language,
    authorization,
    cloud_front_forwarded_proto,
    cloud_front_is_desktop_viewer,
    cloud_front_is_mobile_viewer,
    cloud_front_is_smart_tv_viewer,
    cloud_front_is_tablet_viewer,
    cloud_front_viewer_country,
    host,
    origin,
    referer,

    pub const json_field_names = .{
        .accept = "Accept",
        .accept_charset = "Accept-Charset",
        .accept_datetime = "Accept-Datetime",
        .accept_encoding = "Accept-Encoding",
        .accept_language = "Accept-Language",
        .authorization = "Authorization",
        .cloud_front_forwarded_proto = "CloudFront-Forwarded-Proto",
        .cloud_front_is_desktop_viewer = "CloudFront-Is-Desktop-Viewer",
        .cloud_front_is_mobile_viewer = "CloudFront-Is-Mobile-Viewer",
        .cloud_front_is_smart_tv_viewer = "CloudFront-Is-SmartTV-Viewer",
        .cloud_front_is_tablet_viewer = "CloudFront-Is-Tablet-Viewer",
        .cloud_front_viewer_country = "CloudFront-Viewer-Country",
        .host = "Host",
        .origin = "Origin",
        .referer = "Referer",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .accept => "Accept",
            .accept_charset => "Accept-Charset",
            .accept_datetime => "Accept-Datetime",
            .accept_encoding => "Accept-Encoding",
            .accept_language => "Accept-Language",
            .authorization => "Authorization",
            .cloud_front_forwarded_proto => "CloudFront-Forwarded-Proto",
            .cloud_front_is_desktop_viewer => "CloudFront-Is-Desktop-Viewer",
            .cloud_front_is_mobile_viewer => "CloudFront-Is-Mobile-Viewer",
            .cloud_front_is_smart_tv_viewer => "CloudFront-Is-SmartTV-Viewer",
            .cloud_front_is_tablet_viewer => "CloudFront-Is-Tablet-Viewer",
            .cloud_front_viewer_country => "CloudFront-Viewer-Country",
            .host => "Host",
            .origin => "Origin",
            .referer => "Referer",
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
