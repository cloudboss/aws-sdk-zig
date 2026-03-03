const Flow = @import("flow.zig").Flow;

pub const UpdateFlowResponse = struct {
    /// The updated flow.
    flow: ?Flow = null,

    pub const json_field_names = .{
        .flow = "Flow",
    };
};
