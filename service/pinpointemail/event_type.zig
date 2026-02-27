/// An email sending event type. For example, email sends, opens, and bounces
/// are all
/// email events.
pub const EventType = enum {
    send,
    reject,
    bounce,
    complaint,
    delivery,
    open,
    click,
    rendering_failure,

    pub const json_field_names = .{
        .send = "SEND",
        .reject = "REJECT",
        .bounce = "BOUNCE",
        .complaint = "COMPLAINT",
        .delivery = "DELIVERY",
        .open = "OPEN",
        .click = "CLICK",
        .rendering_failure = "RENDERING_FAILURE",
    };
};
