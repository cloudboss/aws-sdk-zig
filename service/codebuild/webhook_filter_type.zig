pub const WebhookFilterType = enum {
    event,
    base_ref,
    head_ref,
    actor_account_id,
    file_path,
    commit_message,
    workflow_name,
    tag_name,
    release_name,
    repository_name,
    organization_name,

    pub const json_field_names = .{
        .event = "EVENT",
        .base_ref = "BASE_REF",
        .head_ref = "HEAD_REF",
        .actor_account_id = "ACTOR_ACCOUNT_ID",
        .file_path = "FILE_PATH",
        .commit_message = "COMMIT_MESSAGE",
        .workflow_name = "WORKFLOW_NAME",
        .tag_name = "TAG_NAME",
        .release_name = "RELEASE_NAME",
        .repository_name = "REPOSITORY_NAME",
        .organization_name = "ORGANIZATION_NAME",
    };
};
