const AccessibilityType = @import("accessibility_type.zig").AccessibilityType;
const DashRoleCaption = @import("dash_role_caption.zig").DashRoleCaption;
const CaptionDestinationSettings = @import("caption_destination_settings.zig").CaptionDestinationSettings;
const DvbDashAccessibility = @import("dvb_dash_accessibility.zig").DvbDashAccessibility;

/// Caption Description
pub const CaptionDescription = struct {
    /// Indicates whether the caption track implements accessibility features such
    /// as written descriptions of spoken dialog, music, and sounds. This signaling
    /// is added to HLS output group and MediaPackage output group.
    accessibility: ?AccessibilityType = null,

    /// Identifies the DASH roles to assign to this captions output. Applies only
    /// when the captions output is configured for DVB DASH accessibility signaling.
    caption_dash_roles: ?[]const DashRoleCaption = null,

    /// Specifies which input caption selector to use as a caption source when
    /// generating output captions. This field should match a captionSelector name.
    caption_selector_name: []const u8,

    /// Additional settings for captions destination that depend on the destination
    /// type.
    destination_settings: ?CaptionDestinationSettings = null,

    /// Identifies DVB DASH accessibility signaling in this captions output. Used in
    /// Microsoft Smooth Streaming outputs to signal accessibility information to
    /// packagers.
    dvb_dash_accessibility: ?DvbDashAccessibility = null,

    /// ISO 639-2 three-digit code: http://www.loc.gov/standards/iso639-2/
    language_code: ?[]const u8 = null,

    /// Human readable information to indicate captions available for players (eg.
    /// English, or Spanish).
    language_description: ?[]const u8 = null,

    /// Name of the caption description. Used to associate a caption description
    /// with an output. Names must be unique within an event.
    name: []const u8,

    pub const json_field_names = .{
        .accessibility = "Accessibility",
        .caption_dash_roles = "CaptionDashRoles",
        .caption_selector_name = "CaptionSelectorName",
        .destination_settings = "DestinationSettings",
        .dvb_dash_accessibility = "DvbDashAccessibility",
        .language_code = "LanguageCode",
        .language_description = "LanguageDescription",
        .name = "Name",
    };
};
