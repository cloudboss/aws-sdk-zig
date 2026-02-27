pub const CustomMLMemberAbility = enum {
    can_receive_model_output,
    can_receive_inference_output,

    pub const json_field_names = .{
        .can_receive_model_output = "CAN_RECEIVE_MODEL_OUTPUT",
        .can_receive_inference_output = "CAN_RECEIVE_INFERENCE_OUTPUT",
    };
};
