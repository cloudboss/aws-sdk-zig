const std = @import("std");

pub const AssetCategoryType = enum {
    favicon_ico,
    favicon_svg,
    email_graphic,
    sms_graphic,
    auth_app_graphic,
    password_graphic,
    passkey_graphic,
    page_header_logo,
    page_header_background,
    page_footer_logo,
    page_footer_background,
    page_background,
    form_background,
    form_logo,
    idp_button_icon,

    pub const json_field_names = .{
        .favicon_ico = "FAVICON_ICO",
        .favicon_svg = "FAVICON_SVG",
        .email_graphic = "EMAIL_GRAPHIC",
        .sms_graphic = "SMS_GRAPHIC",
        .auth_app_graphic = "AUTH_APP_GRAPHIC",
        .password_graphic = "PASSWORD_GRAPHIC",
        .passkey_graphic = "PASSKEY_GRAPHIC",
        .page_header_logo = "PAGE_HEADER_LOGO",
        .page_header_background = "PAGE_HEADER_BACKGROUND",
        .page_footer_logo = "PAGE_FOOTER_LOGO",
        .page_footer_background = "PAGE_FOOTER_BACKGROUND",
        .page_background = "PAGE_BACKGROUND",
        .form_background = "FORM_BACKGROUND",
        .form_logo = "FORM_LOGO",
        .idp_button_icon = "IDP_BUTTON_ICON",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .favicon_ico => "FAVICON_ICO",
            .favicon_svg => "FAVICON_SVG",
            .email_graphic => "EMAIL_GRAPHIC",
            .sms_graphic => "SMS_GRAPHIC",
            .auth_app_graphic => "AUTH_APP_GRAPHIC",
            .password_graphic => "PASSWORD_GRAPHIC",
            .passkey_graphic => "PASSKEY_GRAPHIC",
            .page_header_logo => "PAGE_HEADER_LOGO",
            .page_header_background => "PAGE_HEADER_BACKGROUND",
            .page_footer_logo => "PAGE_FOOTER_LOGO",
            .page_footer_background => "PAGE_FOOTER_BACKGROUND",
            .page_background => "PAGE_BACKGROUND",
            .form_background => "FORM_BACKGROUND",
            .form_logo => "FORM_LOGO",
            .idp_button_icon => "IDP_BUTTON_ICON",
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
