const ContactState = @import("contact_state.zig").ContactState;

/// Filters user data based on the contact information that is associated to the
/// users. It contains a list of [contact
/// states](https://docs.aws.amazon.com/connect/latest/adminguide/about-contact-states.html).
pub const ContactFilter = struct {
    /// A list of up to 9 [contact
    /// states](https://docs.aws.amazon.com/connect/latest/adminguide/about-contact-states.html).
    contact_states: ?[]const ContactState = null,

    pub const json_field_names = .{
        .contact_states = "ContactStates",
    };
};
