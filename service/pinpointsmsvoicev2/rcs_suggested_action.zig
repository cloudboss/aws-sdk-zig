const RcsCreateCalendarEventAction = @import("rcs_create_calendar_event_action.zig").RcsCreateCalendarEventAction;
const RcsDialPhoneAction = @import("rcs_dial_phone_action.zig").RcsDialPhoneAction;
const RcsOpenUrlAction = @import("rcs_open_url_action.zig").RcsOpenUrlAction;
const RcsReplyAction = @import("rcs_reply_action.zig").RcsReplyAction;
const RcsRequestLocationAction = @import("rcs_request_location_action.zig").RcsRequestLocationAction;
const RcsShowLocationAction = @import("rcs_show_location_action.zig").RcsShowLocationAction;

/// A suggested action displayed to the RCS message recipient. Can be a reply,
/// open URL, dial phone, show location, request location, or create calendar
/// event.
pub const RcsSuggestedAction = union(enum) {
    /// A suggested action that creates a calendar event on the user's device.
    create_calendar_event: ?RcsCreateCalendarEventAction,
    /// A suggested action that initiates a phone call to the specified number.
    dial_phone: ?RcsDialPhoneAction,
    /// A suggested action that opens a URL in the user's browser or a webview.
    open_url: ?RcsOpenUrlAction,
    /// A suggested reply that sends predefined text and postback data when tapped.
    reply: ?RcsReplyAction,
    /// A suggested action that requests the user's current location.
    request_location: ?RcsRequestLocationAction,
    /// A suggested action that shows a location on a map.
    show_location: ?RcsShowLocationAction,

    pub const json_field_names = .{
        .create_calendar_event = "CreateCalendarEvent",
        .dial_phone = "DialPhone",
        .open_url = "OpenUrl",
        .reply = "Reply",
        .request_location = "RequestLocation",
        .show_location = "ShowLocation",
    };
};
