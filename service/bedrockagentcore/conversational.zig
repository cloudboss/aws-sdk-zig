const Content = @import("content.zig").Content;
const Role = @import("role.zig").Role;

/// Contains conversational content for an event payload.
pub const Conversational = struct {
    /// The content of the conversation message.
    content: Content,

    /// The role of the participant in the conversation (for example, "user" or
    /// "assistant").
    role: Role,

    pub const json_field_names = .{
        .content = "content",
        .role = "role",
    };
};
