const HlsAkamaiSettings = @import("hls_akamai_settings.zig").HlsAkamaiSettings;
const HlsBasicPutSettings = @import("hls_basic_put_settings.zig").HlsBasicPutSettings;
const HlsMediaStoreSettings = @import("hls_media_store_settings.zig").HlsMediaStoreSettings;
const HlsS3Settings = @import("hls_s3_settings.zig").HlsS3Settings;
const HlsWebdavSettings = @import("hls_webdav_settings.zig").HlsWebdavSettings;

/// Hls Cdn Settings
pub const HlsCdnSettings = struct {
    hls_akamai_settings: ?HlsAkamaiSettings,

    hls_basic_put_settings: ?HlsBasicPutSettings,

    hls_media_store_settings: ?HlsMediaStoreSettings,

    hls_s3_settings: ?HlsS3Settings,

    hls_webdav_settings: ?HlsWebdavSettings,

    pub const json_field_names = .{
        .hls_akamai_settings = "HlsAkamaiSettings",
        .hls_basic_put_settings = "HlsBasicPutSettings",
        .hls_media_store_settings = "HlsMediaStoreSettings",
        .hls_s3_settings = "HlsS3Settings",
        .hls_webdav_settings = "HlsWebdavSettings",
    };
};
