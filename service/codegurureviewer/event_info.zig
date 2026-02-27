/// Information about an event. The event might be a push, pull request,
/// scheduled request,
/// or another type of event.
pub const EventInfo = struct {
    /// The name of the event. The possible names are `pull_request`,
    /// `workflow_dispatch`, `schedule`, and `push`
    name: ?[]const u8,

    /// The state of an event. The state might be open, closed, or another state.
    state: ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
        .state = "State",
    };
};
