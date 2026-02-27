pub const ActionType = enum {
    create_task,
    assign_contact_category,
    generate_eventbridge_event,
    send_notification,
    create_case,
    update_case,
    assign_sla,
    end_associated_tasks,
    submit_auto_evaluation,

    pub const json_field_names = .{
        .create_task = "CREATE_TASK",
        .assign_contact_category = "ASSIGN_CONTACT_CATEGORY",
        .generate_eventbridge_event = "GENERATE_EVENTBRIDGE_EVENT",
        .send_notification = "SEND_NOTIFICATION",
        .create_case = "CREATE_CASE",
        .update_case = "UPDATE_CASE",
        .assign_sla = "ASSIGN_SLA",
        .end_associated_tasks = "END_ASSOCIATED_TASKS",
        .submit_auto_evaluation = "SUBMIT_AUTO_EVALUATION",
    };
};
