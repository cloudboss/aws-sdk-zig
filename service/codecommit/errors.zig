const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        actor_does_not_exist_exception: ActorDoesNotExistException,
        approval_rule_content_required_exception: ApprovalRuleContentRequiredException,
        approval_rule_does_not_exist_exception: ApprovalRuleDoesNotExistException,
        approval_rule_name_already_exists_exception: ApprovalRuleNameAlreadyExistsException,
        approval_rule_name_required_exception: ApprovalRuleNameRequiredException,
        approval_rule_template_content_required_exception: ApprovalRuleTemplateContentRequiredException,
        approval_rule_template_does_not_exist_exception: ApprovalRuleTemplateDoesNotExistException,
        approval_rule_template_in_use_exception: ApprovalRuleTemplateInUseException,
        approval_rule_template_name_already_exists_exception: ApprovalRuleTemplateNameAlreadyExistsException,
        approval_rule_template_name_required_exception: ApprovalRuleTemplateNameRequiredException,
        approval_state_required_exception: ApprovalStateRequiredException,
        author_does_not_exist_exception: AuthorDoesNotExistException,
        before_commit_id_and_after_commit_id_are_same_exception: BeforeCommitIdAndAfterCommitIdAreSameException,
        blob_id_does_not_exist_exception: BlobIdDoesNotExistException,
        blob_id_required_exception: BlobIdRequiredException,
        branch_does_not_exist_exception: BranchDoesNotExistException,
        branch_name_exists_exception: BranchNameExistsException,
        branch_name_is_tag_name_exception: BranchNameIsTagNameException,
        branch_name_required_exception: BranchNameRequiredException,
        cannot_delete_approval_rule_from_template_exception: CannotDeleteApprovalRuleFromTemplateException,
        cannot_modify_approval_rule_from_template_exception: CannotModifyApprovalRuleFromTemplateException,
        client_request_token_required_exception: ClientRequestTokenRequiredException,
        comment_content_required_exception: CommentContentRequiredException,
        comment_content_size_limit_exceeded_exception: CommentContentSizeLimitExceededException,
        comment_deleted_exception: CommentDeletedException,
        comment_does_not_exist_exception: CommentDoesNotExistException,
        comment_id_required_exception: CommentIdRequiredException,
        comment_not_created_by_caller_exception: CommentNotCreatedByCallerException,
        commit_does_not_exist_exception: CommitDoesNotExistException,
        commit_id_does_not_exist_exception: CommitIdDoesNotExistException,
        commit_id_required_exception: CommitIdRequiredException,
        commit_ids_limit_exceeded_exception: CommitIdsLimitExceededException,
        commit_ids_list_required_exception: CommitIdsListRequiredException,
        commit_message_length_exceeded_exception: CommitMessageLengthExceededException,
        commit_required_exception: CommitRequiredException,
        concurrent_reference_update_exception: ConcurrentReferenceUpdateException,
        default_branch_cannot_be_deleted_exception: DefaultBranchCannotBeDeletedException,
        directory_name_conflicts_with_file_name_exception: DirectoryNameConflictsWithFileNameException,
        encryption_integrity_checks_failed_exception: EncryptionIntegrityChecksFailedException,
        encryption_key_access_denied_exception: EncryptionKeyAccessDeniedException,
        encryption_key_disabled_exception: EncryptionKeyDisabledException,
        encryption_key_invalid_id_exception: EncryptionKeyInvalidIdException,
        encryption_key_invalid_usage_exception: EncryptionKeyInvalidUsageException,
        encryption_key_not_found_exception: EncryptionKeyNotFoundException,
        encryption_key_required_exception: EncryptionKeyRequiredException,
        encryption_key_unavailable_exception: EncryptionKeyUnavailableException,
        file_content_and_source_file_specified_exception: FileContentAndSourceFileSpecifiedException,
        file_content_required_exception: FileContentRequiredException,
        file_content_size_limit_exceeded_exception: FileContentSizeLimitExceededException,
        file_does_not_exist_exception: FileDoesNotExistException,
        file_entry_required_exception: FileEntryRequiredException,
        file_mode_required_exception: FileModeRequiredException,
        file_name_conflicts_with_directory_name_exception: FileNameConflictsWithDirectoryNameException,
        file_path_conflicts_with_submodule_path_exception: FilePathConflictsWithSubmodulePathException,
        file_too_large_exception: FileTooLargeException,
        folder_content_size_limit_exceeded_exception: FolderContentSizeLimitExceededException,
        folder_does_not_exist_exception: FolderDoesNotExistException,
        idempotency_parameter_mismatch_exception: IdempotencyParameterMismatchException,
        invalid_actor_arn_exception: InvalidActorArnException,
        invalid_approval_rule_content_exception: InvalidApprovalRuleContentException,
        invalid_approval_rule_name_exception: InvalidApprovalRuleNameException,
        invalid_approval_rule_template_content_exception: InvalidApprovalRuleTemplateContentException,
        invalid_approval_rule_template_description_exception: InvalidApprovalRuleTemplateDescriptionException,
        invalid_approval_rule_template_name_exception: InvalidApprovalRuleTemplateNameException,
        invalid_approval_state_exception: InvalidApprovalStateException,
        invalid_author_arn_exception: InvalidAuthorArnException,
        invalid_blob_id_exception: InvalidBlobIdException,
        invalid_branch_name_exception: InvalidBranchNameException,
        invalid_client_request_token_exception: InvalidClientRequestTokenException,
        invalid_comment_id_exception: InvalidCommentIdException,
        invalid_commit_exception: InvalidCommitException,
        invalid_commit_id_exception: InvalidCommitIdException,
        invalid_conflict_detail_level_exception: InvalidConflictDetailLevelException,
        invalid_conflict_resolution_exception: InvalidConflictResolutionException,
        invalid_conflict_resolution_strategy_exception: InvalidConflictResolutionStrategyException,
        invalid_continuation_token_exception: InvalidContinuationTokenException,
        invalid_deletion_parameter_exception: InvalidDeletionParameterException,
        invalid_description_exception: InvalidDescriptionException,
        invalid_destination_commit_specifier_exception: InvalidDestinationCommitSpecifierException,
        invalid_email_exception: InvalidEmailException,
        invalid_file_location_exception: InvalidFileLocationException,
        invalid_file_mode_exception: InvalidFileModeException,
        invalid_file_position_exception: InvalidFilePositionException,
        invalid_max_conflict_files_exception: InvalidMaxConflictFilesException,
        invalid_max_merge_hunks_exception: InvalidMaxMergeHunksException,
        invalid_max_results_exception: InvalidMaxResultsException,
        invalid_merge_option_exception: InvalidMergeOptionException,
        invalid_order_exception: InvalidOrderException,
        invalid_override_status_exception: InvalidOverrideStatusException,
        invalid_parent_commit_id_exception: InvalidParentCommitIdException,
        invalid_path_exception: InvalidPathException,
        invalid_pull_request_event_type_exception: InvalidPullRequestEventTypeException,
        invalid_pull_request_id_exception: InvalidPullRequestIdException,
        invalid_pull_request_status_exception: InvalidPullRequestStatusException,
        invalid_pull_request_status_update_exception: InvalidPullRequestStatusUpdateException,
        invalid_reaction_user_arn_exception: InvalidReactionUserArnException,
        invalid_reaction_value_exception: InvalidReactionValueException,
        invalid_reference_name_exception: InvalidReferenceNameException,
        invalid_relative_file_version_enum_exception: InvalidRelativeFileVersionEnumException,
        invalid_replacement_content_exception: InvalidReplacementContentException,
        invalid_replacement_type_exception: InvalidReplacementTypeException,
        invalid_repository_description_exception: InvalidRepositoryDescriptionException,
        invalid_repository_name_exception: InvalidRepositoryNameException,
        invalid_repository_trigger_branch_name_exception: InvalidRepositoryTriggerBranchNameException,
        invalid_repository_trigger_custom_data_exception: InvalidRepositoryTriggerCustomDataException,
        invalid_repository_trigger_destination_arn_exception: InvalidRepositoryTriggerDestinationArnException,
        invalid_repository_trigger_events_exception: InvalidRepositoryTriggerEventsException,
        invalid_repository_trigger_name_exception: InvalidRepositoryTriggerNameException,
        invalid_repository_trigger_region_exception: InvalidRepositoryTriggerRegionException,
        invalid_resource_arn_exception: InvalidResourceArnException,
        invalid_revision_id_exception: InvalidRevisionIdException,
        invalid_rule_content_sha_256_exception: InvalidRuleContentSha256Exception,
        invalid_sort_by_exception: InvalidSortByException,
        invalid_source_commit_specifier_exception: InvalidSourceCommitSpecifierException,
        invalid_system_tag_usage_exception: InvalidSystemTagUsageException,
        invalid_tag_keys_list_exception: InvalidTagKeysListException,
        invalid_tags_map_exception: InvalidTagsMapException,
        invalid_target_branch_exception: InvalidTargetBranchException,
        invalid_target_exception: InvalidTargetException,
        invalid_targets_exception: InvalidTargetsException,
        invalid_title_exception: InvalidTitleException,
        manual_merge_required_exception: ManualMergeRequiredException,
        maximum_branches_exceeded_exception: MaximumBranchesExceededException,
        maximum_conflict_resolution_entries_exceeded_exception: MaximumConflictResolutionEntriesExceededException,
        maximum_file_content_to_load_exceeded_exception: MaximumFileContentToLoadExceededException,
        maximum_file_entries_exceeded_exception: MaximumFileEntriesExceededException,
        maximum_items_to_compare_exceeded_exception: MaximumItemsToCompareExceededException,
        maximum_number_of_approvals_exceeded_exception: MaximumNumberOfApprovalsExceededException,
        maximum_open_pull_requests_exceeded_exception: MaximumOpenPullRequestsExceededException,
        maximum_repository_names_exceeded_exception: MaximumRepositoryNamesExceededException,
        maximum_repository_triggers_exceeded_exception: MaximumRepositoryTriggersExceededException,
        maximum_rule_templates_associated_with_repository_exception: MaximumRuleTemplatesAssociatedWithRepositoryException,
        merge_option_required_exception: MergeOptionRequiredException,
        multiple_conflict_resolution_entries_exception: MultipleConflictResolutionEntriesException,
        multiple_repositories_in_pull_request_exception: MultipleRepositoriesInPullRequestException,
        name_length_exceeded_exception: NameLengthExceededException,
        no_change_exception: NoChangeException,
        number_of_rule_templates_exceeded_exception: NumberOfRuleTemplatesExceededException,
        number_of_rules_exceeded_exception: NumberOfRulesExceededException,
        operation_not_allowed_exception: OperationNotAllowedException,
        override_already_set_exception: OverrideAlreadySetException,
        override_status_required_exception: OverrideStatusRequiredException,
        parent_commit_does_not_exist_exception: ParentCommitDoesNotExistException,
        parent_commit_id_outdated_exception: ParentCommitIdOutdatedException,
        parent_commit_id_required_exception: ParentCommitIdRequiredException,
        path_does_not_exist_exception: PathDoesNotExistException,
        path_required_exception: PathRequiredException,
        pull_request_already_closed_exception: PullRequestAlreadyClosedException,
        pull_request_approval_rules_not_satisfied_exception: PullRequestApprovalRulesNotSatisfiedException,
        pull_request_cannot_be_approved_by_author_exception: PullRequestCannotBeApprovedByAuthorException,
        pull_request_does_not_exist_exception: PullRequestDoesNotExistException,
        pull_request_id_required_exception: PullRequestIdRequiredException,
        pull_request_status_required_exception: PullRequestStatusRequiredException,
        put_file_entry_conflict_exception: PutFileEntryConflictException,
        reaction_limit_exceeded_exception: ReactionLimitExceededException,
        reaction_value_required_exception: ReactionValueRequiredException,
        reference_does_not_exist_exception: ReferenceDoesNotExistException,
        reference_name_required_exception: ReferenceNameRequiredException,
        reference_type_not_supported_exception: ReferenceTypeNotSupportedException,
        replacement_content_required_exception: ReplacementContentRequiredException,
        replacement_type_required_exception: ReplacementTypeRequiredException,
        repository_does_not_exist_exception: RepositoryDoesNotExistException,
        repository_limit_exceeded_exception: RepositoryLimitExceededException,
        repository_name_exists_exception: RepositoryNameExistsException,
        repository_name_required_exception: RepositoryNameRequiredException,
        repository_names_required_exception: RepositoryNamesRequiredException,
        repository_not_associated_with_pull_request_exception: RepositoryNotAssociatedWithPullRequestException,
        repository_trigger_branch_name_list_required_exception: RepositoryTriggerBranchNameListRequiredException,
        repository_trigger_destination_arn_required_exception: RepositoryTriggerDestinationArnRequiredException,
        repository_trigger_events_list_required_exception: RepositoryTriggerEventsListRequiredException,
        repository_trigger_name_required_exception: RepositoryTriggerNameRequiredException,
        repository_triggers_list_required_exception: RepositoryTriggersListRequiredException,
        resource_arn_required_exception: ResourceArnRequiredException,
        restricted_source_file_exception: RestrictedSourceFileException,
        revision_id_required_exception: RevisionIdRequiredException,
        revision_not_current_exception: RevisionNotCurrentException,
        same_file_content_exception: SameFileContentException,
        same_path_request_exception: SamePathRequestException,
        source_and_destination_are_same_exception: SourceAndDestinationAreSameException,
        source_file_or_content_required_exception: SourceFileOrContentRequiredException,
        tag_keys_list_required_exception: TagKeysListRequiredException,
        tag_policy_exception: TagPolicyException,
        tags_map_required_exception: TagsMapRequiredException,
        target_required_exception: TargetRequiredException,
        targets_required_exception: TargetsRequiredException,
        tip_of_source_reference_is_different_exception: TipOfSourceReferenceIsDifferentException,
        tips_divergence_exceeded_exception: TipsDivergenceExceededException,
        title_required_exception: TitleRequiredException,
        too_many_tags_exception: TooManyTagsException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .actor_does_not_exist_exception => "ActorDoesNotExistException",
                .approval_rule_content_required_exception => "ApprovalRuleContentRequiredException",
                .approval_rule_does_not_exist_exception => "ApprovalRuleDoesNotExistException",
                .approval_rule_name_already_exists_exception => "ApprovalRuleNameAlreadyExistsException",
                .approval_rule_name_required_exception => "ApprovalRuleNameRequiredException",
                .approval_rule_template_content_required_exception => "ApprovalRuleTemplateContentRequiredException",
                .approval_rule_template_does_not_exist_exception => "ApprovalRuleTemplateDoesNotExistException",
                .approval_rule_template_in_use_exception => "ApprovalRuleTemplateInUseException",
                .approval_rule_template_name_already_exists_exception => "ApprovalRuleTemplateNameAlreadyExistsException",
                .approval_rule_template_name_required_exception => "ApprovalRuleTemplateNameRequiredException",
                .approval_state_required_exception => "ApprovalStateRequiredException",
                .author_does_not_exist_exception => "AuthorDoesNotExistException",
                .before_commit_id_and_after_commit_id_are_same_exception => "BeforeCommitIdAndAfterCommitIdAreSameException",
                .blob_id_does_not_exist_exception => "BlobIdDoesNotExistException",
                .blob_id_required_exception => "BlobIdRequiredException",
                .branch_does_not_exist_exception => "BranchDoesNotExistException",
                .branch_name_exists_exception => "BranchNameExistsException",
                .branch_name_is_tag_name_exception => "BranchNameIsTagNameException",
                .branch_name_required_exception => "BranchNameRequiredException",
                .cannot_delete_approval_rule_from_template_exception => "CannotDeleteApprovalRuleFromTemplateException",
                .cannot_modify_approval_rule_from_template_exception => "CannotModifyApprovalRuleFromTemplateException",
                .client_request_token_required_exception => "ClientRequestTokenRequiredException",
                .comment_content_required_exception => "CommentContentRequiredException",
                .comment_content_size_limit_exceeded_exception => "CommentContentSizeLimitExceededException",
                .comment_deleted_exception => "CommentDeletedException",
                .comment_does_not_exist_exception => "CommentDoesNotExistException",
                .comment_id_required_exception => "CommentIdRequiredException",
                .comment_not_created_by_caller_exception => "CommentNotCreatedByCallerException",
                .commit_does_not_exist_exception => "CommitDoesNotExistException",
                .commit_id_does_not_exist_exception => "CommitIdDoesNotExistException",
                .commit_id_required_exception => "CommitIdRequiredException",
                .commit_ids_limit_exceeded_exception => "CommitIdsLimitExceededException",
                .commit_ids_list_required_exception => "CommitIdsListRequiredException",
                .commit_message_length_exceeded_exception => "CommitMessageLengthExceededException",
                .commit_required_exception => "CommitRequiredException",
                .concurrent_reference_update_exception => "ConcurrentReferenceUpdateException",
                .default_branch_cannot_be_deleted_exception => "DefaultBranchCannotBeDeletedException",
                .directory_name_conflicts_with_file_name_exception => "DirectoryNameConflictsWithFileNameException",
                .encryption_integrity_checks_failed_exception => "EncryptionIntegrityChecksFailedException",
                .encryption_key_access_denied_exception => "EncryptionKeyAccessDeniedException",
                .encryption_key_disabled_exception => "EncryptionKeyDisabledException",
                .encryption_key_invalid_id_exception => "EncryptionKeyInvalidIdException",
                .encryption_key_invalid_usage_exception => "EncryptionKeyInvalidUsageException",
                .encryption_key_not_found_exception => "EncryptionKeyNotFoundException",
                .encryption_key_required_exception => "EncryptionKeyRequiredException",
                .encryption_key_unavailable_exception => "EncryptionKeyUnavailableException",
                .file_content_and_source_file_specified_exception => "FileContentAndSourceFileSpecifiedException",
                .file_content_required_exception => "FileContentRequiredException",
                .file_content_size_limit_exceeded_exception => "FileContentSizeLimitExceededException",
                .file_does_not_exist_exception => "FileDoesNotExistException",
                .file_entry_required_exception => "FileEntryRequiredException",
                .file_mode_required_exception => "FileModeRequiredException",
                .file_name_conflicts_with_directory_name_exception => "FileNameConflictsWithDirectoryNameException",
                .file_path_conflicts_with_submodule_path_exception => "FilePathConflictsWithSubmodulePathException",
                .file_too_large_exception => "FileTooLargeException",
                .folder_content_size_limit_exceeded_exception => "FolderContentSizeLimitExceededException",
                .folder_does_not_exist_exception => "FolderDoesNotExistException",
                .idempotency_parameter_mismatch_exception => "IdempotencyParameterMismatchException",
                .invalid_actor_arn_exception => "InvalidActorArnException",
                .invalid_approval_rule_content_exception => "InvalidApprovalRuleContentException",
                .invalid_approval_rule_name_exception => "InvalidApprovalRuleNameException",
                .invalid_approval_rule_template_content_exception => "InvalidApprovalRuleTemplateContentException",
                .invalid_approval_rule_template_description_exception => "InvalidApprovalRuleTemplateDescriptionException",
                .invalid_approval_rule_template_name_exception => "InvalidApprovalRuleTemplateNameException",
                .invalid_approval_state_exception => "InvalidApprovalStateException",
                .invalid_author_arn_exception => "InvalidAuthorArnException",
                .invalid_blob_id_exception => "InvalidBlobIdException",
                .invalid_branch_name_exception => "InvalidBranchNameException",
                .invalid_client_request_token_exception => "InvalidClientRequestTokenException",
                .invalid_comment_id_exception => "InvalidCommentIdException",
                .invalid_commit_exception => "InvalidCommitException",
                .invalid_commit_id_exception => "InvalidCommitIdException",
                .invalid_conflict_detail_level_exception => "InvalidConflictDetailLevelException",
                .invalid_conflict_resolution_exception => "InvalidConflictResolutionException",
                .invalid_conflict_resolution_strategy_exception => "InvalidConflictResolutionStrategyException",
                .invalid_continuation_token_exception => "InvalidContinuationTokenException",
                .invalid_deletion_parameter_exception => "InvalidDeletionParameterException",
                .invalid_description_exception => "InvalidDescriptionException",
                .invalid_destination_commit_specifier_exception => "InvalidDestinationCommitSpecifierException",
                .invalid_email_exception => "InvalidEmailException",
                .invalid_file_location_exception => "InvalidFileLocationException",
                .invalid_file_mode_exception => "InvalidFileModeException",
                .invalid_file_position_exception => "InvalidFilePositionException",
                .invalid_max_conflict_files_exception => "InvalidMaxConflictFilesException",
                .invalid_max_merge_hunks_exception => "InvalidMaxMergeHunksException",
                .invalid_max_results_exception => "InvalidMaxResultsException",
                .invalid_merge_option_exception => "InvalidMergeOptionException",
                .invalid_order_exception => "InvalidOrderException",
                .invalid_override_status_exception => "InvalidOverrideStatusException",
                .invalid_parent_commit_id_exception => "InvalidParentCommitIdException",
                .invalid_path_exception => "InvalidPathException",
                .invalid_pull_request_event_type_exception => "InvalidPullRequestEventTypeException",
                .invalid_pull_request_id_exception => "InvalidPullRequestIdException",
                .invalid_pull_request_status_exception => "InvalidPullRequestStatusException",
                .invalid_pull_request_status_update_exception => "InvalidPullRequestStatusUpdateException",
                .invalid_reaction_user_arn_exception => "InvalidReactionUserArnException",
                .invalid_reaction_value_exception => "InvalidReactionValueException",
                .invalid_reference_name_exception => "InvalidReferenceNameException",
                .invalid_relative_file_version_enum_exception => "InvalidRelativeFileVersionEnumException",
                .invalid_replacement_content_exception => "InvalidReplacementContentException",
                .invalid_replacement_type_exception => "InvalidReplacementTypeException",
                .invalid_repository_description_exception => "InvalidRepositoryDescriptionException",
                .invalid_repository_name_exception => "InvalidRepositoryNameException",
                .invalid_repository_trigger_branch_name_exception => "InvalidRepositoryTriggerBranchNameException",
                .invalid_repository_trigger_custom_data_exception => "InvalidRepositoryTriggerCustomDataException",
                .invalid_repository_trigger_destination_arn_exception => "InvalidRepositoryTriggerDestinationArnException",
                .invalid_repository_trigger_events_exception => "InvalidRepositoryTriggerEventsException",
                .invalid_repository_trigger_name_exception => "InvalidRepositoryTriggerNameException",
                .invalid_repository_trigger_region_exception => "InvalidRepositoryTriggerRegionException",
                .invalid_resource_arn_exception => "InvalidResourceArnException",
                .invalid_revision_id_exception => "InvalidRevisionIdException",
                .invalid_rule_content_sha_256_exception => "InvalidRuleContentSha256Exception",
                .invalid_sort_by_exception => "InvalidSortByException",
                .invalid_source_commit_specifier_exception => "InvalidSourceCommitSpecifierException",
                .invalid_system_tag_usage_exception => "InvalidSystemTagUsageException",
                .invalid_tag_keys_list_exception => "InvalidTagKeysListException",
                .invalid_tags_map_exception => "InvalidTagsMapException",
                .invalid_target_branch_exception => "InvalidTargetBranchException",
                .invalid_target_exception => "InvalidTargetException",
                .invalid_targets_exception => "InvalidTargetsException",
                .invalid_title_exception => "InvalidTitleException",
                .manual_merge_required_exception => "ManualMergeRequiredException",
                .maximum_branches_exceeded_exception => "MaximumBranchesExceededException",
                .maximum_conflict_resolution_entries_exceeded_exception => "MaximumConflictResolutionEntriesExceededException",
                .maximum_file_content_to_load_exceeded_exception => "MaximumFileContentToLoadExceededException",
                .maximum_file_entries_exceeded_exception => "MaximumFileEntriesExceededException",
                .maximum_items_to_compare_exceeded_exception => "MaximumItemsToCompareExceededException",
                .maximum_number_of_approvals_exceeded_exception => "MaximumNumberOfApprovalsExceededException",
                .maximum_open_pull_requests_exceeded_exception => "MaximumOpenPullRequestsExceededException",
                .maximum_repository_names_exceeded_exception => "MaximumRepositoryNamesExceededException",
                .maximum_repository_triggers_exceeded_exception => "MaximumRepositoryTriggersExceededException",
                .maximum_rule_templates_associated_with_repository_exception => "MaximumRuleTemplatesAssociatedWithRepositoryException",
                .merge_option_required_exception => "MergeOptionRequiredException",
                .multiple_conflict_resolution_entries_exception => "MultipleConflictResolutionEntriesException",
                .multiple_repositories_in_pull_request_exception => "MultipleRepositoriesInPullRequestException",
                .name_length_exceeded_exception => "NameLengthExceededException",
                .no_change_exception => "NoChangeException",
                .number_of_rule_templates_exceeded_exception => "NumberOfRuleTemplatesExceededException",
                .number_of_rules_exceeded_exception => "NumberOfRulesExceededException",
                .operation_not_allowed_exception => "OperationNotAllowedException",
                .override_already_set_exception => "OverrideAlreadySetException",
                .override_status_required_exception => "OverrideStatusRequiredException",
                .parent_commit_does_not_exist_exception => "ParentCommitDoesNotExistException",
                .parent_commit_id_outdated_exception => "ParentCommitIdOutdatedException",
                .parent_commit_id_required_exception => "ParentCommitIdRequiredException",
                .path_does_not_exist_exception => "PathDoesNotExistException",
                .path_required_exception => "PathRequiredException",
                .pull_request_already_closed_exception => "PullRequestAlreadyClosedException",
                .pull_request_approval_rules_not_satisfied_exception => "PullRequestApprovalRulesNotSatisfiedException",
                .pull_request_cannot_be_approved_by_author_exception => "PullRequestCannotBeApprovedByAuthorException",
                .pull_request_does_not_exist_exception => "PullRequestDoesNotExistException",
                .pull_request_id_required_exception => "PullRequestIdRequiredException",
                .pull_request_status_required_exception => "PullRequestStatusRequiredException",
                .put_file_entry_conflict_exception => "PutFileEntryConflictException",
                .reaction_limit_exceeded_exception => "ReactionLimitExceededException",
                .reaction_value_required_exception => "ReactionValueRequiredException",
                .reference_does_not_exist_exception => "ReferenceDoesNotExistException",
                .reference_name_required_exception => "ReferenceNameRequiredException",
                .reference_type_not_supported_exception => "ReferenceTypeNotSupportedException",
                .replacement_content_required_exception => "ReplacementContentRequiredException",
                .replacement_type_required_exception => "ReplacementTypeRequiredException",
                .repository_does_not_exist_exception => "RepositoryDoesNotExistException",
                .repository_limit_exceeded_exception => "RepositoryLimitExceededException",
                .repository_name_exists_exception => "RepositoryNameExistsException",
                .repository_name_required_exception => "RepositoryNameRequiredException",
                .repository_names_required_exception => "RepositoryNamesRequiredException",
                .repository_not_associated_with_pull_request_exception => "RepositoryNotAssociatedWithPullRequestException",
                .repository_trigger_branch_name_list_required_exception => "RepositoryTriggerBranchNameListRequiredException",
                .repository_trigger_destination_arn_required_exception => "RepositoryTriggerDestinationArnRequiredException",
                .repository_trigger_events_list_required_exception => "RepositoryTriggerEventsListRequiredException",
                .repository_trigger_name_required_exception => "RepositoryTriggerNameRequiredException",
                .repository_triggers_list_required_exception => "RepositoryTriggersListRequiredException",
                .resource_arn_required_exception => "ResourceArnRequiredException",
                .restricted_source_file_exception => "RestrictedSourceFileException",
                .revision_id_required_exception => "RevisionIdRequiredException",
                .revision_not_current_exception => "RevisionNotCurrentException",
                .same_file_content_exception => "SameFileContentException",
                .same_path_request_exception => "SamePathRequestException",
                .source_and_destination_are_same_exception => "SourceAndDestinationAreSameException",
                .source_file_or_content_required_exception => "SourceFileOrContentRequiredException",
                .tag_keys_list_required_exception => "TagKeysListRequiredException",
                .tag_policy_exception => "TagPolicyException",
                .tags_map_required_exception => "TagsMapRequiredException",
                .target_required_exception => "TargetRequiredException",
                .targets_required_exception => "TargetsRequiredException",
                .tip_of_source_reference_is_different_exception => "TipOfSourceReferenceIsDifferentException",
                .tips_divergence_exceeded_exception => "TipsDivergenceExceededException",
                .title_required_exception => "TitleRequiredException",
                .too_many_tags_exception => "TooManyTagsException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .actor_does_not_exist_exception => |e| e.message,
                .approval_rule_content_required_exception => |e| e.message,
                .approval_rule_does_not_exist_exception => |e| e.message,
                .approval_rule_name_already_exists_exception => |e| e.message,
                .approval_rule_name_required_exception => |e| e.message,
                .approval_rule_template_content_required_exception => |e| e.message,
                .approval_rule_template_does_not_exist_exception => |e| e.message,
                .approval_rule_template_in_use_exception => |e| e.message,
                .approval_rule_template_name_already_exists_exception => |e| e.message,
                .approval_rule_template_name_required_exception => |e| e.message,
                .approval_state_required_exception => |e| e.message,
                .author_does_not_exist_exception => |e| e.message,
                .before_commit_id_and_after_commit_id_are_same_exception => |e| e.message,
                .blob_id_does_not_exist_exception => |e| e.message,
                .blob_id_required_exception => |e| e.message,
                .branch_does_not_exist_exception => |e| e.message,
                .branch_name_exists_exception => |e| e.message,
                .branch_name_is_tag_name_exception => |e| e.message,
                .branch_name_required_exception => |e| e.message,
                .cannot_delete_approval_rule_from_template_exception => |e| e.message,
                .cannot_modify_approval_rule_from_template_exception => |e| e.message,
                .client_request_token_required_exception => |e| e.message,
                .comment_content_required_exception => |e| e.message,
                .comment_content_size_limit_exceeded_exception => |e| e.message,
                .comment_deleted_exception => |e| e.message,
                .comment_does_not_exist_exception => |e| e.message,
                .comment_id_required_exception => |e| e.message,
                .comment_not_created_by_caller_exception => |e| e.message,
                .commit_does_not_exist_exception => |e| e.message,
                .commit_id_does_not_exist_exception => |e| e.message,
                .commit_id_required_exception => |e| e.message,
                .commit_ids_limit_exceeded_exception => |e| e.message,
                .commit_ids_list_required_exception => |e| e.message,
                .commit_message_length_exceeded_exception => |e| e.message,
                .commit_required_exception => |e| e.message,
                .concurrent_reference_update_exception => |e| e.message,
                .default_branch_cannot_be_deleted_exception => |e| e.message,
                .directory_name_conflicts_with_file_name_exception => |e| e.message,
                .encryption_integrity_checks_failed_exception => |e| e.message,
                .encryption_key_access_denied_exception => |e| e.message,
                .encryption_key_disabled_exception => |e| e.message,
                .encryption_key_invalid_id_exception => |e| e.message,
                .encryption_key_invalid_usage_exception => |e| e.message,
                .encryption_key_not_found_exception => |e| e.message,
                .encryption_key_required_exception => |e| e.message,
                .encryption_key_unavailable_exception => |e| e.message,
                .file_content_and_source_file_specified_exception => |e| e.message,
                .file_content_required_exception => |e| e.message,
                .file_content_size_limit_exceeded_exception => |e| e.message,
                .file_does_not_exist_exception => |e| e.message,
                .file_entry_required_exception => |e| e.message,
                .file_mode_required_exception => |e| e.message,
                .file_name_conflicts_with_directory_name_exception => |e| e.message,
                .file_path_conflicts_with_submodule_path_exception => |e| e.message,
                .file_too_large_exception => |e| e.message,
                .folder_content_size_limit_exceeded_exception => |e| e.message,
                .folder_does_not_exist_exception => |e| e.message,
                .idempotency_parameter_mismatch_exception => |e| e.message,
                .invalid_actor_arn_exception => |e| e.message,
                .invalid_approval_rule_content_exception => |e| e.message,
                .invalid_approval_rule_name_exception => |e| e.message,
                .invalid_approval_rule_template_content_exception => |e| e.message,
                .invalid_approval_rule_template_description_exception => |e| e.message,
                .invalid_approval_rule_template_name_exception => |e| e.message,
                .invalid_approval_state_exception => |e| e.message,
                .invalid_author_arn_exception => |e| e.message,
                .invalid_blob_id_exception => |e| e.message,
                .invalid_branch_name_exception => |e| e.message,
                .invalid_client_request_token_exception => |e| e.message,
                .invalid_comment_id_exception => |e| e.message,
                .invalid_commit_exception => |e| e.message,
                .invalid_commit_id_exception => |e| e.message,
                .invalid_conflict_detail_level_exception => |e| e.message,
                .invalid_conflict_resolution_exception => |e| e.message,
                .invalid_conflict_resolution_strategy_exception => |e| e.message,
                .invalid_continuation_token_exception => |e| e.message,
                .invalid_deletion_parameter_exception => |e| e.message,
                .invalid_description_exception => |e| e.message,
                .invalid_destination_commit_specifier_exception => |e| e.message,
                .invalid_email_exception => |e| e.message,
                .invalid_file_location_exception => |e| e.message,
                .invalid_file_mode_exception => |e| e.message,
                .invalid_file_position_exception => |e| e.message,
                .invalid_max_conflict_files_exception => |e| e.message,
                .invalid_max_merge_hunks_exception => |e| e.message,
                .invalid_max_results_exception => |e| e.message,
                .invalid_merge_option_exception => |e| e.message,
                .invalid_order_exception => |e| e.message,
                .invalid_override_status_exception => |e| e.message,
                .invalid_parent_commit_id_exception => |e| e.message,
                .invalid_path_exception => |e| e.message,
                .invalid_pull_request_event_type_exception => |e| e.message,
                .invalid_pull_request_id_exception => |e| e.message,
                .invalid_pull_request_status_exception => |e| e.message,
                .invalid_pull_request_status_update_exception => |e| e.message,
                .invalid_reaction_user_arn_exception => |e| e.message,
                .invalid_reaction_value_exception => |e| e.message,
                .invalid_reference_name_exception => |e| e.message,
                .invalid_relative_file_version_enum_exception => |e| e.message,
                .invalid_replacement_content_exception => |e| e.message,
                .invalid_replacement_type_exception => |e| e.message,
                .invalid_repository_description_exception => |e| e.message,
                .invalid_repository_name_exception => |e| e.message,
                .invalid_repository_trigger_branch_name_exception => |e| e.message,
                .invalid_repository_trigger_custom_data_exception => |e| e.message,
                .invalid_repository_trigger_destination_arn_exception => |e| e.message,
                .invalid_repository_trigger_events_exception => |e| e.message,
                .invalid_repository_trigger_name_exception => |e| e.message,
                .invalid_repository_trigger_region_exception => |e| e.message,
                .invalid_resource_arn_exception => |e| e.message,
                .invalid_revision_id_exception => |e| e.message,
                .invalid_rule_content_sha_256_exception => |e| e.message,
                .invalid_sort_by_exception => |e| e.message,
                .invalid_source_commit_specifier_exception => |e| e.message,
                .invalid_system_tag_usage_exception => |e| e.message,
                .invalid_tag_keys_list_exception => |e| e.message,
                .invalid_tags_map_exception => |e| e.message,
                .invalid_target_branch_exception => |e| e.message,
                .invalid_target_exception => |e| e.message,
                .invalid_targets_exception => |e| e.message,
                .invalid_title_exception => |e| e.message,
                .manual_merge_required_exception => |e| e.message,
                .maximum_branches_exceeded_exception => |e| e.message,
                .maximum_conflict_resolution_entries_exceeded_exception => |e| e.message,
                .maximum_file_content_to_load_exceeded_exception => |e| e.message,
                .maximum_file_entries_exceeded_exception => |e| e.message,
                .maximum_items_to_compare_exceeded_exception => |e| e.message,
                .maximum_number_of_approvals_exceeded_exception => |e| e.message,
                .maximum_open_pull_requests_exceeded_exception => |e| e.message,
                .maximum_repository_names_exceeded_exception => |e| e.message,
                .maximum_repository_triggers_exceeded_exception => |e| e.message,
                .maximum_rule_templates_associated_with_repository_exception => |e| e.message,
                .merge_option_required_exception => |e| e.message,
                .multiple_conflict_resolution_entries_exception => |e| e.message,
                .multiple_repositories_in_pull_request_exception => |e| e.message,
                .name_length_exceeded_exception => |e| e.message,
                .no_change_exception => |e| e.message,
                .number_of_rule_templates_exceeded_exception => |e| e.message,
                .number_of_rules_exceeded_exception => |e| e.message,
                .operation_not_allowed_exception => |e| e.message,
                .override_already_set_exception => |e| e.message,
                .override_status_required_exception => |e| e.message,
                .parent_commit_does_not_exist_exception => |e| e.message,
                .parent_commit_id_outdated_exception => |e| e.message,
                .parent_commit_id_required_exception => |e| e.message,
                .path_does_not_exist_exception => |e| e.message,
                .path_required_exception => |e| e.message,
                .pull_request_already_closed_exception => |e| e.message,
                .pull_request_approval_rules_not_satisfied_exception => |e| e.message,
                .pull_request_cannot_be_approved_by_author_exception => |e| e.message,
                .pull_request_does_not_exist_exception => |e| e.message,
                .pull_request_id_required_exception => |e| e.message,
                .pull_request_status_required_exception => |e| e.message,
                .put_file_entry_conflict_exception => |e| e.message,
                .reaction_limit_exceeded_exception => |e| e.message,
                .reaction_value_required_exception => |e| e.message,
                .reference_does_not_exist_exception => |e| e.message,
                .reference_name_required_exception => |e| e.message,
                .reference_type_not_supported_exception => |e| e.message,
                .replacement_content_required_exception => |e| e.message,
                .replacement_type_required_exception => |e| e.message,
                .repository_does_not_exist_exception => |e| e.message,
                .repository_limit_exceeded_exception => |e| e.message,
                .repository_name_exists_exception => |e| e.message,
                .repository_name_required_exception => |e| e.message,
                .repository_names_required_exception => |e| e.message,
                .repository_not_associated_with_pull_request_exception => |e| e.message,
                .repository_trigger_branch_name_list_required_exception => |e| e.message,
                .repository_trigger_destination_arn_required_exception => |e| e.message,
                .repository_trigger_events_list_required_exception => |e| e.message,
                .repository_trigger_name_required_exception => |e| e.message,
                .repository_triggers_list_required_exception => |e| e.message,
                .resource_arn_required_exception => |e| e.message,
                .restricted_source_file_exception => |e| e.message,
                .revision_id_required_exception => |e| e.message,
                .revision_not_current_exception => |e| e.message,
                .same_file_content_exception => |e| e.message,
                .same_path_request_exception => |e| e.message,
                .source_and_destination_are_same_exception => |e| e.message,
                .source_file_or_content_required_exception => |e| e.message,
                .tag_keys_list_required_exception => |e| e.message,
                .tag_policy_exception => |e| e.message,
                .tags_map_required_exception => |e| e.message,
                .target_required_exception => |e| e.message,
                .targets_required_exception => |e| e.message,
                .tip_of_source_reference_is_different_exception => |e| e.message,
                .tips_divergence_exceeded_exception => |e| e.message,
                .title_required_exception => |e| e.message,
                .too_many_tags_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .actor_does_not_exist_exception => 400,
                .approval_rule_content_required_exception => 400,
                .approval_rule_does_not_exist_exception => 400,
                .approval_rule_name_already_exists_exception => 400,
                .approval_rule_name_required_exception => 400,
                .approval_rule_template_content_required_exception => 400,
                .approval_rule_template_does_not_exist_exception => 400,
                .approval_rule_template_in_use_exception => 400,
                .approval_rule_template_name_already_exists_exception => 400,
                .approval_rule_template_name_required_exception => 400,
                .approval_state_required_exception => 400,
                .author_does_not_exist_exception => 400,
                .before_commit_id_and_after_commit_id_are_same_exception => 400,
                .blob_id_does_not_exist_exception => 400,
                .blob_id_required_exception => 400,
                .branch_does_not_exist_exception => 400,
                .branch_name_exists_exception => 400,
                .branch_name_is_tag_name_exception => 400,
                .branch_name_required_exception => 400,
                .cannot_delete_approval_rule_from_template_exception => 400,
                .cannot_modify_approval_rule_from_template_exception => 400,
                .client_request_token_required_exception => 400,
                .comment_content_required_exception => 400,
                .comment_content_size_limit_exceeded_exception => 400,
                .comment_deleted_exception => 400,
                .comment_does_not_exist_exception => 400,
                .comment_id_required_exception => 400,
                .comment_not_created_by_caller_exception => 400,
                .commit_does_not_exist_exception => 400,
                .commit_id_does_not_exist_exception => 400,
                .commit_id_required_exception => 400,
                .commit_ids_limit_exceeded_exception => 400,
                .commit_ids_list_required_exception => 400,
                .commit_message_length_exceeded_exception => 400,
                .commit_required_exception => 400,
                .concurrent_reference_update_exception => 400,
                .default_branch_cannot_be_deleted_exception => 400,
                .directory_name_conflicts_with_file_name_exception => 400,
                .encryption_integrity_checks_failed_exception => 500,
                .encryption_key_access_denied_exception => 400,
                .encryption_key_disabled_exception => 400,
                .encryption_key_invalid_id_exception => 400,
                .encryption_key_invalid_usage_exception => 400,
                .encryption_key_not_found_exception => 400,
                .encryption_key_required_exception => 400,
                .encryption_key_unavailable_exception => 400,
                .file_content_and_source_file_specified_exception => 400,
                .file_content_required_exception => 400,
                .file_content_size_limit_exceeded_exception => 400,
                .file_does_not_exist_exception => 400,
                .file_entry_required_exception => 400,
                .file_mode_required_exception => 400,
                .file_name_conflicts_with_directory_name_exception => 400,
                .file_path_conflicts_with_submodule_path_exception => 400,
                .file_too_large_exception => 400,
                .folder_content_size_limit_exceeded_exception => 400,
                .folder_does_not_exist_exception => 400,
                .idempotency_parameter_mismatch_exception => 400,
                .invalid_actor_arn_exception => 400,
                .invalid_approval_rule_content_exception => 400,
                .invalid_approval_rule_name_exception => 400,
                .invalid_approval_rule_template_content_exception => 400,
                .invalid_approval_rule_template_description_exception => 400,
                .invalid_approval_rule_template_name_exception => 400,
                .invalid_approval_state_exception => 400,
                .invalid_author_arn_exception => 400,
                .invalid_blob_id_exception => 400,
                .invalid_branch_name_exception => 400,
                .invalid_client_request_token_exception => 400,
                .invalid_comment_id_exception => 400,
                .invalid_commit_exception => 400,
                .invalid_commit_id_exception => 400,
                .invalid_conflict_detail_level_exception => 400,
                .invalid_conflict_resolution_exception => 400,
                .invalid_conflict_resolution_strategy_exception => 400,
                .invalid_continuation_token_exception => 400,
                .invalid_deletion_parameter_exception => 400,
                .invalid_description_exception => 400,
                .invalid_destination_commit_specifier_exception => 400,
                .invalid_email_exception => 400,
                .invalid_file_location_exception => 400,
                .invalid_file_mode_exception => 400,
                .invalid_file_position_exception => 400,
                .invalid_max_conflict_files_exception => 400,
                .invalid_max_merge_hunks_exception => 400,
                .invalid_max_results_exception => 400,
                .invalid_merge_option_exception => 400,
                .invalid_order_exception => 400,
                .invalid_override_status_exception => 400,
                .invalid_parent_commit_id_exception => 400,
                .invalid_path_exception => 400,
                .invalid_pull_request_event_type_exception => 400,
                .invalid_pull_request_id_exception => 400,
                .invalid_pull_request_status_exception => 400,
                .invalid_pull_request_status_update_exception => 400,
                .invalid_reaction_user_arn_exception => 400,
                .invalid_reaction_value_exception => 400,
                .invalid_reference_name_exception => 400,
                .invalid_relative_file_version_enum_exception => 400,
                .invalid_replacement_content_exception => 400,
                .invalid_replacement_type_exception => 400,
                .invalid_repository_description_exception => 400,
                .invalid_repository_name_exception => 400,
                .invalid_repository_trigger_branch_name_exception => 400,
                .invalid_repository_trigger_custom_data_exception => 400,
                .invalid_repository_trigger_destination_arn_exception => 400,
                .invalid_repository_trigger_events_exception => 400,
                .invalid_repository_trigger_name_exception => 400,
                .invalid_repository_trigger_region_exception => 400,
                .invalid_resource_arn_exception => 400,
                .invalid_revision_id_exception => 400,
                .invalid_rule_content_sha_256_exception => 400,
                .invalid_sort_by_exception => 400,
                .invalid_source_commit_specifier_exception => 400,
                .invalid_system_tag_usage_exception => 400,
                .invalid_tag_keys_list_exception => 400,
                .invalid_tags_map_exception => 400,
                .invalid_target_branch_exception => 400,
                .invalid_target_exception => 400,
                .invalid_targets_exception => 400,
                .invalid_title_exception => 400,
                .manual_merge_required_exception => 400,
                .maximum_branches_exceeded_exception => 400,
                .maximum_conflict_resolution_entries_exceeded_exception => 400,
                .maximum_file_content_to_load_exceeded_exception => 400,
                .maximum_file_entries_exceeded_exception => 400,
                .maximum_items_to_compare_exceeded_exception => 400,
                .maximum_number_of_approvals_exceeded_exception => 400,
                .maximum_open_pull_requests_exceeded_exception => 400,
                .maximum_repository_names_exceeded_exception => 400,
                .maximum_repository_triggers_exceeded_exception => 400,
                .maximum_rule_templates_associated_with_repository_exception => 400,
                .merge_option_required_exception => 400,
                .multiple_conflict_resolution_entries_exception => 400,
                .multiple_repositories_in_pull_request_exception => 400,
                .name_length_exceeded_exception => 400,
                .no_change_exception => 400,
                .number_of_rule_templates_exceeded_exception => 400,
                .number_of_rules_exceeded_exception => 400,
                .operation_not_allowed_exception => 400,
                .override_already_set_exception => 400,
                .override_status_required_exception => 400,
                .parent_commit_does_not_exist_exception => 400,
                .parent_commit_id_outdated_exception => 400,
                .parent_commit_id_required_exception => 400,
                .path_does_not_exist_exception => 400,
                .path_required_exception => 400,
                .pull_request_already_closed_exception => 400,
                .pull_request_approval_rules_not_satisfied_exception => 400,
                .pull_request_cannot_be_approved_by_author_exception => 400,
                .pull_request_does_not_exist_exception => 400,
                .pull_request_id_required_exception => 400,
                .pull_request_status_required_exception => 400,
                .put_file_entry_conflict_exception => 400,
                .reaction_limit_exceeded_exception => 400,
                .reaction_value_required_exception => 400,
                .reference_does_not_exist_exception => 400,
                .reference_name_required_exception => 400,
                .reference_type_not_supported_exception => 400,
                .replacement_content_required_exception => 400,
                .replacement_type_required_exception => 400,
                .repository_does_not_exist_exception => 400,
                .repository_limit_exceeded_exception => 400,
                .repository_name_exists_exception => 400,
                .repository_name_required_exception => 400,
                .repository_names_required_exception => 400,
                .repository_not_associated_with_pull_request_exception => 400,
                .repository_trigger_branch_name_list_required_exception => 400,
                .repository_trigger_destination_arn_required_exception => 400,
                .repository_trigger_events_list_required_exception => 400,
                .repository_trigger_name_required_exception => 400,
                .repository_triggers_list_required_exception => 400,
                .resource_arn_required_exception => 400,
                .restricted_source_file_exception => 400,
                .revision_id_required_exception => 400,
                .revision_not_current_exception => 400,
                .same_file_content_exception => 400,
                .same_path_request_exception => 400,
                .source_and_destination_are_same_exception => 400,
                .source_file_or_content_required_exception => 400,
                .tag_keys_list_required_exception => 400,
                .tag_policy_exception => 400,
                .tags_map_required_exception => 400,
                .target_required_exception => 400,
                .targets_required_exception => 400,
                .tip_of_source_reference_is_different_exception => 400,
                .tips_divergence_exceeded_exception => 400,
                .title_required_exception => 400,
                .too_many_tags_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .actor_does_not_exist_exception => |e| e.request_id,
                .approval_rule_content_required_exception => |e| e.request_id,
                .approval_rule_does_not_exist_exception => |e| e.request_id,
                .approval_rule_name_already_exists_exception => |e| e.request_id,
                .approval_rule_name_required_exception => |e| e.request_id,
                .approval_rule_template_content_required_exception => |e| e.request_id,
                .approval_rule_template_does_not_exist_exception => |e| e.request_id,
                .approval_rule_template_in_use_exception => |e| e.request_id,
                .approval_rule_template_name_already_exists_exception => |e| e.request_id,
                .approval_rule_template_name_required_exception => |e| e.request_id,
                .approval_state_required_exception => |e| e.request_id,
                .author_does_not_exist_exception => |e| e.request_id,
                .before_commit_id_and_after_commit_id_are_same_exception => |e| e.request_id,
                .blob_id_does_not_exist_exception => |e| e.request_id,
                .blob_id_required_exception => |e| e.request_id,
                .branch_does_not_exist_exception => |e| e.request_id,
                .branch_name_exists_exception => |e| e.request_id,
                .branch_name_is_tag_name_exception => |e| e.request_id,
                .branch_name_required_exception => |e| e.request_id,
                .cannot_delete_approval_rule_from_template_exception => |e| e.request_id,
                .cannot_modify_approval_rule_from_template_exception => |e| e.request_id,
                .client_request_token_required_exception => |e| e.request_id,
                .comment_content_required_exception => |e| e.request_id,
                .comment_content_size_limit_exceeded_exception => |e| e.request_id,
                .comment_deleted_exception => |e| e.request_id,
                .comment_does_not_exist_exception => |e| e.request_id,
                .comment_id_required_exception => |e| e.request_id,
                .comment_not_created_by_caller_exception => |e| e.request_id,
                .commit_does_not_exist_exception => |e| e.request_id,
                .commit_id_does_not_exist_exception => |e| e.request_id,
                .commit_id_required_exception => |e| e.request_id,
                .commit_ids_limit_exceeded_exception => |e| e.request_id,
                .commit_ids_list_required_exception => |e| e.request_id,
                .commit_message_length_exceeded_exception => |e| e.request_id,
                .commit_required_exception => |e| e.request_id,
                .concurrent_reference_update_exception => |e| e.request_id,
                .default_branch_cannot_be_deleted_exception => |e| e.request_id,
                .directory_name_conflicts_with_file_name_exception => |e| e.request_id,
                .encryption_integrity_checks_failed_exception => |e| e.request_id,
                .encryption_key_access_denied_exception => |e| e.request_id,
                .encryption_key_disabled_exception => |e| e.request_id,
                .encryption_key_invalid_id_exception => |e| e.request_id,
                .encryption_key_invalid_usage_exception => |e| e.request_id,
                .encryption_key_not_found_exception => |e| e.request_id,
                .encryption_key_required_exception => |e| e.request_id,
                .encryption_key_unavailable_exception => |e| e.request_id,
                .file_content_and_source_file_specified_exception => |e| e.request_id,
                .file_content_required_exception => |e| e.request_id,
                .file_content_size_limit_exceeded_exception => |e| e.request_id,
                .file_does_not_exist_exception => |e| e.request_id,
                .file_entry_required_exception => |e| e.request_id,
                .file_mode_required_exception => |e| e.request_id,
                .file_name_conflicts_with_directory_name_exception => |e| e.request_id,
                .file_path_conflicts_with_submodule_path_exception => |e| e.request_id,
                .file_too_large_exception => |e| e.request_id,
                .folder_content_size_limit_exceeded_exception => |e| e.request_id,
                .folder_does_not_exist_exception => |e| e.request_id,
                .idempotency_parameter_mismatch_exception => |e| e.request_id,
                .invalid_actor_arn_exception => |e| e.request_id,
                .invalid_approval_rule_content_exception => |e| e.request_id,
                .invalid_approval_rule_name_exception => |e| e.request_id,
                .invalid_approval_rule_template_content_exception => |e| e.request_id,
                .invalid_approval_rule_template_description_exception => |e| e.request_id,
                .invalid_approval_rule_template_name_exception => |e| e.request_id,
                .invalid_approval_state_exception => |e| e.request_id,
                .invalid_author_arn_exception => |e| e.request_id,
                .invalid_blob_id_exception => |e| e.request_id,
                .invalid_branch_name_exception => |e| e.request_id,
                .invalid_client_request_token_exception => |e| e.request_id,
                .invalid_comment_id_exception => |e| e.request_id,
                .invalid_commit_exception => |e| e.request_id,
                .invalid_commit_id_exception => |e| e.request_id,
                .invalid_conflict_detail_level_exception => |e| e.request_id,
                .invalid_conflict_resolution_exception => |e| e.request_id,
                .invalid_conflict_resolution_strategy_exception => |e| e.request_id,
                .invalid_continuation_token_exception => |e| e.request_id,
                .invalid_deletion_parameter_exception => |e| e.request_id,
                .invalid_description_exception => |e| e.request_id,
                .invalid_destination_commit_specifier_exception => |e| e.request_id,
                .invalid_email_exception => |e| e.request_id,
                .invalid_file_location_exception => |e| e.request_id,
                .invalid_file_mode_exception => |e| e.request_id,
                .invalid_file_position_exception => |e| e.request_id,
                .invalid_max_conflict_files_exception => |e| e.request_id,
                .invalid_max_merge_hunks_exception => |e| e.request_id,
                .invalid_max_results_exception => |e| e.request_id,
                .invalid_merge_option_exception => |e| e.request_id,
                .invalid_order_exception => |e| e.request_id,
                .invalid_override_status_exception => |e| e.request_id,
                .invalid_parent_commit_id_exception => |e| e.request_id,
                .invalid_path_exception => |e| e.request_id,
                .invalid_pull_request_event_type_exception => |e| e.request_id,
                .invalid_pull_request_id_exception => |e| e.request_id,
                .invalid_pull_request_status_exception => |e| e.request_id,
                .invalid_pull_request_status_update_exception => |e| e.request_id,
                .invalid_reaction_user_arn_exception => |e| e.request_id,
                .invalid_reaction_value_exception => |e| e.request_id,
                .invalid_reference_name_exception => |e| e.request_id,
                .invalid_relative_file_version_enum_exception => |e| e.request_id,
                .invalid_replacement_content_exception => |e| e.request_id,
                .invalid_replacement_type_exception => |e| e.request_id,
                .invalid_repository_description_exception => |e| e.request_id,
                .invalid_repository_name_exception => |e| e.request_id,
                .invalid_repository_trigger_branch_name_exception => |e| e.request_id,
                .invalid_repository_trigger_custom_data_exception => |e| e.request_id,
                .invalid_repository_trigger_destination_arn_exception => |e| e.request_id,
                .invalid_repository_trigger_events_exception => |e| e.request_id,
                .invalid_repository_trigger_name_exception => |e| e.request_id,
                .invalid_repository_trigger_region_exception => |e| e.request_id,
                .invalid_resource_arn_exception => |e| e.request_id,
                .invalid_revision_id_exception => |e| e.request_id,
                .invalid_rule_content_sha_256_exception => |e| e.request_id,
                .invalid_sort_by_exception => |e| e.request_id,
                .invalid_source_commit_specifier_exception => |e| e.request_id,
                .invalid_system_tag_usage_exception => |e| e.request_id,
                .invalid_tag_keys_list_exception => |e| e.request_id,
                .invalid_tags_map_exception => |e| e.request_id,
                .invalid_target_branch_exception => |e| e.request_id,
                .invalid_target_exception => |e| e.request_id,
                .invalid_targets_exception => |e| e.request_id,
                .invalid_title_exception => |e| e.request_id,
                .manual_merge_required_exception => |e| e.request_id,
                .maximum_branches_exceeded_exception => |e| e.request_id,
                .maximum_conflict_resolution_entries_exceeded_exception => |e| e.request_id,
                .maximum_file_content_to_load_exceeded_exception => |e| e.request_id,
                .maximum_file_entries_exceeded_exception => |e| e.request_id,
                .maximum_items_to_compare_exceeded_exception => |e| e.request_id,
                .maximum_number_of_approvals_exceeded_exception => |e| e.request_id,
                .maximum_open_pull_requests_exceeded_exception => |e| e.request_id,
                .maximum_repository_names_exceeded_exception => |e| e.request_id,
                .maximum_repository_triggers_exceeded_exception => |e| e.request_id,
                .maximum_rule_templates_associated_with_repository_exception => |e| e.request_id,
                .merge_option_required_exception => |e| e.request_id,
                .multiple_conflict_resolution_entries_exception => |e| e.request_id,
                .multiple_repositories_in_pull_request_exception => |e| e.request_id,
                .name_length_exceeded_exception => |e| e.request_id,
                .no_change_exception => |e| e.request_id,
                .number_of_rule_templates_exceeded_exception => |e| e.request_id,
                .number_of_rules_exceeded_exception => |e| e.request_id,
                .operation_not_allowed_exception => |e| e.request_id,
                .override_already_set_exception => |e| e.request_id,
                .override_status_required_exception => |e| e.request_id,
                .parent_commit_does_not_exist_exception => |e| e.request_id,
                .parent_commit_id_outdated_exception => |e| e.request_id,
                .parent_commit_id_required_exception => |e| e.request_id,
                .path_does_not_exist_exception => |e| e.request_id,
                .path_required_exception => |e| e.request_id,
                .pull_request_already_closed_exception => |e| e.request_id,
                .pull_request_approval_rules_not_satisfied_exception => |e| e.request_id,
                .pull_request_cannot_be_approved_by_author_exception => |e| e.request_id,
                .pull_request_does_not_exist_exception => |e| e.request_id,
                .pull_request_id_required_exception => |e| e.request_id,
                .pull_request_status_required_exception => |e| e.request_id,
                .put_file_entry_conflict_exception => |e| e.request_id,
                .reaction_limit_exceeded_exception => |e| e.request_id,
                .reaction_value_required_exception => |e| e.request_id,
                .reference_does_not_exist_exception => |e| e.request_id,
                .reference_name_required_exception => |e| e.request_id,
                .reference_type_not_supported_exception => |e| e.request_id,
                .replacement_content_required_exception => |e| e.request_id,
                .replacement_type_required_exception => |e| e.request_id,
                .repository_does_not_exist_exception => |e| e.request_id,
                .repository_limit_exceeded_exception => |e| e.request_id,
                .repository_name_exists_exception => |e| e.request_id,
                .repository_name_required_exception => |e| e.request_id,
                .repository_names_required_exception => |e| e.request_id,
                .repository_not_associated_with_pull_request_exception => |e| e.request_id,
                .repository_trigger_branch_name_list_required_exception => |e| e.request_id,
                .repository_trigger_destination_arn_required_exception => |e| e.request_id,
                .repository_trigger_events_list_required_exception => |e| e.request_id,
                .repository_trigger_name_required_exception => |e| e.request_id,
                .repository_triggers_list_required_exception => |e| e.request_id,
                .resource_arn_required_exception => |e| e.request_id,
                .restricted_source_file_exception => |e| e.request_id,
                .revision_id_required_exception => |e| e.request_id,
                .revision_not_current_exception => |e| e.request_id,
                .same_file_content_exception => |e| e.request_id,
                .same_path_request_exception => |e| e.request_id,
                .source_and_destination_are_same_exception => |e| e.request_id,
                .source_file_or_content_required_exception => |e| e.request_id,
                .tag_keys_list_required_exception => |e| e.request_id,
                .tag_policy_exception => |e| e.request_id,
                .tags_map_required_exception => |e| e.request_id,
                .target_required_exception => |e| e.request_id,
                .targets_required_exception => |e| e.request_id,
                .tip_of_source_reference_is_different_exception => |e| e.request_id,
                .tips_divergence_exceeded_exception => |e| e.request_id,
                .title_required_exception => |e| e.request_id,
                .too_many_tags_exception => |e| e.request_id,
                .unknown => |e| e.request_id,
            };
        }
    };

    pub fn deinit(self: *ServiceError) void {
        if (self.arena) |*a| a.deinit();
    }

    pub fn code(self: ServiceError) []const u8 {
        return self.kind.code();
    }

    pub fn message(self: ServiceError) []const u8 {
        return self.kind.message();
    }

    pub fn httpStatus(self: ServiceError) u16 {
        return self.kind.httpStatus();
    }

    pub fn requestId(self: ServiceError) []const u8 {
        return self.kind.requestId();
    }
};

/// The specified Amazon Resource Name (ARN) does not exist in the Amazon Web
/// Services account.
pub const ActorDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The content for the approval rule is empty. You must provide some content
/// for an approval rule. The content cannot be null.
pub const ApprovalRuleContentRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified approval rule does not exist.
pub const ApprovalRuleDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// An approval rule with that name already exists. Approval rule names must be
/// unique
/// within the scope of a pull request.
pub const ApprovalRuleNameAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// An approval rule name is required, but was not specified.
pub const ApprovalRuleNameRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The content for the approval rule template is empty. You must provide some
/// content for an approval rule template. The content cannot be null.
pub const ApprovalRuleTemplateContentRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified approval rule template does not exist. Verify that the name is
/// correct and that you are signed in to the Amazon Web Services Region where
/// the template
/// was created, and then try again.
pub const ApprovalRuleTemplateDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The approval rule template is associated with one or more repositories. You
/// cannot delete a template that is associated with a repository. Remove
/// all associations, and then try again.
pub const ApprovalRuleTemplateInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You cannot create an approval rule template with that name because a
/// template with
/// that name already exists in this Amazon Web Services Region for your Amazon
/// Web Services account. Approval rule template
/// names must be unique.
pub const ApprovalRuleTemplateNameAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// An approval rule template name is required, but was not specified.
pub const ApprovalRuleTemplateNameRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// An approval state is required, but was not specified.
pub const ApprovalStateRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified Amazon Resource Name (ARN) does not exist in the Amazon Web
/// Services account.
pub const AuthorDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The before commit ID and the after commit ID are the same, which is not
/// valid. The before commit ID and the after commit ID must be different commit
/// IDs.
pub const BeforeCommitIdAndAfterCommitIdAreSameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified blob does not exist.
pub const BlobIdDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A blob ID is required, but was not specified.
pub const BlobIdRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified branch does not exist.
pub const BranchDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Cannot create the branch with the specified name because the commit
/// conflicts with an existing branch with the same name.
///
/// Branch names must be unique.
pub const BranchNameExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified branch name is not valid because it is a tag name. Enter the
/// name of a
/// branch in the repository. For a list of valid branch names, use
/// ListBranches.
pub const BranchNameIsTagNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A branch name is required, but was not specified.
pub const BranchNameRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The approval rule cannot be deleted from the pull request because it was
/// created by an
/// approval rule template and applied to the pull request automatically.
pub const CannotDeleteApprovalRuleFromTemplateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The approval rule cannot be modified for the pull request because it was
/// created by an
/// approval rule template and applied to the pull request automatically.
pub const CannotModifyApprovalRuleFromTemplateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A client request token is required. A client request token is an unique,
/// client-generated idempotency token that, when provided in a request, ensures
/// the request
/// cannot be repeated with a changed parameter. If a request is received with
/// the same
/// parameters and a token is included, the request returns information about
/// the initial
/// request that used that token.
pub const ClientRequestTokenRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The comment is empty. You must provide some content for a comment. The
/// content cannot be null.
pub const CommentContentRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The comment is too large. Comments are limited to 10,240 characters.
pub const CommentContentSizeLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This comment has already been deleted. You cannot edit or delete a deleted
/// comment.
pub const CommentDeletedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// No comment exists with the provided ID. Verify that you have used the
/// correct ID, and
/// then try again.
pub const CommentDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The comment ID is missing or null. A comment ID is required.
pub const CommentIdRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You cannot modify or delete this comment. Only comment authors can modify or
/// delete their comments.
pub const CommentNotCreatedByCallerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified commit does not exist or no commit was specified, and the
/// specified repository has no default branch.
pub const CommitDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified commit ID does not exist.
pub const CommitIdDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A commit ID was not specified.
pub const CommitIdRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The maximum number of allowed commit IDs in a batch request is 100. Verify
/// that your batch requests contains no more than 100 commit IDs, and then try
/// again.
pub const CommitIdsLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A list of commit IDs is required, but was either not specified or the list
/// was empty.
pub const CommitIdsListRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The commit message is too long. Provide a shorter string.
pub const CommitMessageLengthExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A commit was not specified.
pub const CommitRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The merge cannot be completed because the target branch has been modified.
/// Another user might have modified the target branch while the merge was in
/// progress. Wait a few minutes, and then try again.
pub const ConcurrentReferenceUpdateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified branch is the default branch for the repository, and cannot be
/// deleted. To delete this branch, you must first set another branch as the
/// default branch.
pub const DefaultBranchCannotBeDeletedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A file cannot be added to the repository because the specified path name has
/// the same name as a file that already exists in this repository.
/// Either provide a different name for the file, or specify a different path
/// for the file.
pub const DirectoryNameConflictsWithFileNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// An encryption integrity check failed.
pub const EncryptionIntegrityChecksFailedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// An encryption key could not be accessed.
pub const EncryptionKeyAccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The encryption key is disabled.
pub const EncryptionKeyDisabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The Key Management Service encryption key is not valid.
pub const EncryptionKeyInvalidIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A KMS encryption key was used to try and encrypt or decrypt a repository,
/// but either the repository or the key was not
/// in a valid state to support the operation.
pub const EncryptionKeyInvalidUsageException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// No encryption key was found.
pub const EncryptionKeyNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A KMS encryption key ID is required but was not specified.
pub const EncryptionKeyRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The encryption key is not available.
pub const EncryptionKeyUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The commit cannot be created because both a source file and file content
/// have been
/// specified for the same file. You cannot provide both. Either specify a
/// source file or
/// provide the file content directly.
pub const FileContentAndSourceFileSpecifiedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The file cannot be added because it is empty. Empty files cannot be added to
/// the repository with this API.
pub const FileContentRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The file cannot be added because it is too large. The maximum file size is 6
/// MB, and
/// the combined file content change size is 7 MB. Consider making these changes
/// using a Git
/// client.
pub const FileContentSizeLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified file does not exist. Verify that you have used the correct
/// file name,
/// full path, and extension.
pub const FileDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The commit cannot be created because no files have been specified as added,
/// updated, or changed (PutFile or DeleteFile) for the commit.
pub const FileEntryRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The commit cannot be created because no file mode has been specified. A file
/// mode is
/// required to update mode permissions for a file.
pub const FileModeRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A file cannot be added to the repository because the specified file name has
/// the same name as a directory in this repository. Either provide
/// another name for the file, or add the file in a directory that does not
/// match the file name.
pub const FileNameConflictsWithDirectoryNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The commit cannot be created because a specified file path points to a
/// submodule. Verify that the destination files
/// have valid file paths that do not point to a submodule.
pub const FilePathConflictsWithSubmodulePathException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified file exceeds the file size limit for CodeCommit. For more
/// information about limits in CodeCommit, see
/// [Quotas](https://docs.aws.amazon.com/codecommit/latest/userguide/limits.html) in the *CodeCommit User Guide*.
pub const FileTooLargeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The commit cannot be created because at least one of the overall changes in
/// the commit results in a
/// folder whose contents exceed the limit of 6 MB. Either reduce the number and
/// size of your changes,
/// or split the changes across multiple folders.
pub const FolderContentSizeLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified folder does not exist. Either the folder name is not correct,
/// or you did
/// not enter the full path to the folder.
pub const FolderDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The client request token is not valid. Either the token is not in a valid
/// format, or
/// the token has been used in a previous request and cannot be reused.
pub const IdempotencyParameterMismatchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The Amazon Resource Name (ARN) is not valid. Make sure that you have
/// provided the full ARN for the user who initiated the change for the pull
/// request,
/// and then try again.
pub const InvalidActorArnException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The content for the approval rule is not valid.
pub const InvalidApprovalRuleContentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The name for the approval rule is not valid.
pub const InvalidApprovalRuleNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The content of the approval rule template is not valid.
pub const InvalidApprovalRuleTemplateContentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The description for the approval rule template is not valid because it
/// exceeds the
/// maximum characters allowed for a description. For more information about
/// limits in CodeCommit,
/// see
/// [Quotas](https://docs.aws.amazon.com/codecommit/latest/userguide/limits.html) in the *CodeCommit User Guide*.
pub const InvalidApprovalRuleTemplateDescriptionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The name of the approval rule template is not valid. Template names must be
/// between 1
/// and 100 valid characters in length. For more information about limits in
/// CodeCommit,
/// see
/// [Quotas](https://docs.aws.amazon.com/codecommit/latest/userguide/limits.html) in the *CodeCommit User Guide*.
pub const InvalidApprovalRuleTemplateNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The state for the approval is not valid. Valid values include APPROVE and
/// REVOKE.
pub const InvalidApprovalStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The Amazon Resource Name (ARN) is not valid. Make sure that you have
/// provided the full ARN for the author of the pull request, and then try
/// again.
pub const InvalidAuthorArnException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified blob is not valid.
pub const InvalidBlobIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified reference name is not valid.
pub const InvalidBranchNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The client request token is not valid.
pub const InvalidClientRequestTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The comment ID is not in a valid format. Make sure that you have provided
/// the full comment ID.
pub const InvalidCommentIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified commit is not valid.
pub const InvalidCommitException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified commit ID is not valid.
pub const InvalidCommitIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified conflict detail level is not valid.
pub const InvalidConflictDetailLevelException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified conflict resolution list is not valid.
pub const InvalidConflictResolutionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified conflict resolution strategy is not valid.
pub const InvalidConflictResolutionStrategyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified continuation token is not valid.
pub const InvalidContinuationTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified deletion parameter is not valid.
pub const InvalidDeletionParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The pull request description is not valid. Descriptions cannot be more than
/// 1,000
/// characters.
pub const InvalidDescriptionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The destination commit specifier is not valid. You must provide a valid
/// branch name, tag, or full commit ID.
pub const InvalidDestinationCommitSpecifierException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified email address either contains one or more characters that are
/// not allowed, or it exceeds the maximum number of characters
/// allowed for an email address.
pub const InvalidEmailException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The location of the file is not valid. Make sure that you include the file
/// name and
/// extension.
pub const InvalidFileLocationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified file mode permission is not valid. For a list of valid file
/// mode permissions, see PutFile.
pub const InvalidFileModeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The position is not valid. Make sure that the line number exists in the
/// version of the file you want to comment on.
pub const InvalidFilePositionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified value for the number of conflict files to return is not valid.
pub const InvalidMaxConflictFilesException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified value for the number of merge hunks to return is not valid.
pub const InvalidMaxMergeHunksException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified number of maximum results is not valid.
pub const InvalidMaxResultsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified merge option is not valid for this operation. Not all merge
/// strategies are supported for all operations.
pub const InvalidMergeOptionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified sort order is not valid.
pub const InvalidOrderException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The override status is not valid. Valid statuses are OVERRIDE and REVOKE.
pub const InvalidOverrideStatusException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The parent commit ID is not valid. The commit ID cannot be empty, and must
/// match the head commit ID for the branch of the repository where you
/// want to add or update a file.
pub const InvalidParentCommitIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified path is not valid.
pub const InvalidPathException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The pull request event type is not valid.
pub const InvalidPullRequestEventTypeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The pull request ID is not valid. Make sure that you have provided the full
/// ID and that the pull request is in the specified repository, and then try
/// again.
pub const InvalidPullRequestIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The pull request status is not valid. The only valid values are `OPEN` and
/// `CLOSED`.
pub const InvalidPullRequestStatusException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The pull request status update is not valid. The only valid update is from
/// `OPEN` to `CLOSED`.
pub const InvalidPullRequestStatusUpdateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The Amazon Resource Name (ARN) of the user or identity is not valid.
pub const InvalidReactionUserArnException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The value of the reaction is not valid. For more information, see the
/// [CodeCommit User
/// Guide](https://docs.aws.amazon.com/codecommit/latest/userguide/welcome.html).
pub const InvalidReactionValueException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified reference name format is not valid. Reference names must
/// conform to the
/// Git references format (for example, refs/heads/main). For more information,
/// see [Git Internals -
/// Git References](https://git-scm.com/book/en/v2/Git-Internals-Git-References)
/// or consult your Git documentation.
pub const InvalidReferenceNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Either the enum is not in a valid format, or the specified file version enum
/// is not valid in respect to the current file version.
pub const InvalidRelativeFileVersionEnumException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Automerge was specified for resolving the conflict, but the replacement type
/// is not valid or content is missing.
pub const InvalidReplacementContentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Automerge was specified for resolving the conflict, but the specified
/// replacement type is not valid.
pub const InvalidReplacementTypeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified repository description is not valid.
pub const InvalidRepositoryDescriptionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A specified repository name is not valid.
///
/// This exception occurs only when a specified repository name is not valid.
/// Other
/// exceptions occur when a required repository parameter is missing, or when a
/// specified repository does not exist.
pub const InvalidRepositoryNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// One or more branch names specified for the trigger is not valid.
pub const InvalidRepositoryTriggerBranchNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The custom data provided for the trigger is not valid.
pub const InvalidRepositoryTriggerCustomDataException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The Amazon Resource Name (ARN) for the trigger is not valid for the
/// specified destination. The most common reason for this error is that the ARN
/// does not meet the requirements for the service type.
pub const InvalidRepositoryTriggerDestinationArnException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// One or more events specified for the trigger is not valid. Check to make
/// sure that all events specified match the requirements for allowed events.
pub const InvalidRepositoryTriggerEventsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The name of the trigger is not valid.
pub const InvalidRepositoryTriggerNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The Amazon Web Services Region for the trigger target does not match the
/// Amazon Web Services Region for the
/// repository. Triggers must be created in the same Amazon Web Services Region
/// as the target for the
/// trigger.
pub const InvalidRepositoryTriggerRegionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The value for the resource ARN is not valid. For more information about
/// resources in CodeCommit, see
/// [CodeCommit Resources and
/// Operations](https://docs.aws.amazon.com/codecommit/latest/userguide/auth-and-access-control-iam-access-control-identity-based.html#arn-formats)
/// in the CodeCommit User Guide.
pub const InvalidResourceArnException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The revision ID is not valid. Use GetPullRequest to determine the value.
pub const InvalidRevisionIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The SHA-256 hash signature for the rule content is not valid.
pub const InvalidRuleContentSha256Exception = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified sort by value is not valid.
pub const InvalidSortByException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The source commit specifier is not valid. You must provide a valid branch
/// name, tag, or full commit ID.
pub const InvalidSourceCommitSpecifierException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified tag is not valid. Key names cannot be prefixed with aws:.
pub const InvalidSystemTagUsageException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The list of tags is not valid.
pub const InvalidTagKeysListException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The map of tags is not valid.
pub const InvalidTagsMapException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified target branch is not valid.
pub const InvalidTargetBranchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The target for the pull request is not valid. A target must contain the full
/// values for the repository name, source branch, and destination branch for
/// the pull request.
pub const InvalidTargetException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The targets for the pull request is not valid or not in a valid format.
/// Targets are a list of target objects. Each target object must contain the
/// full values for
/// the repository name, source branch, and destination branch for a pull
/// request.
pub const InvalidTargetsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The title of the pull request is not valid. Pull request titles cannot
/// exceed 100 characters in length.
pub const InvalidTitleException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The pull request cannot be merged automatically into the destination branch.
/// You must manually merge the branches and resolve any conflicts.
pub const ManualMergeRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The number of branches for the trigger was exceeded.
pub const MaximumBranchesExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The number of allowed conflict resolution entries was exceeded.
pub const MaximumConflictResolutionEntriesExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The number of files to load exceeds the allowed limit.
pub const MaximumFileContentToLoadExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The number of specified files to change as part of this commit exceeds the
/// maximum number of files
/// that can be changed in a single commit. Consider using a Git client for
/// these changes.
pub const MaximumFileEntriesExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The number of items to compare between the source or destination branches
/// and the merge base has exceeded the maximum allowed.
pub const MaximumItemsToCompareExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The number of approvals required for the approval rule exceeds the maximum
/// number allowed.
pub const MaximumNumberOfApprovalsExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You cannot create the pull request because the repository has too many open
/// pull requests.
/// The maximum number of open pull requests for a repository is 1,000. Close
/// one or more open pull requests, and then try again.
pub const MaximumOpenPullRequestsExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The maximum number of allowed repository names was exceeded. Currently, this
/// number is 100.
pub const MaximumRepositoryNamesExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The number of triggers allowed for the repository was exceeded.
pub const MaximumRepositoryTriggersExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The maximum number of approval rule templates for a repository has been
/// exceeded. You cannot associate more than 25
/// approval rule templates with a repository.
pub const MaximumRuleTemplatesAssociatedWithRepositoryException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A merge option or stategy is required, and none was provided.
pub const MergeOptionRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// More than one conflict resolution entries exists for the conflict. A
/// conflict can have only one conflict resolution entry.
pub const MultipleConflictResolutionEntriesException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You cannot include more than one repository in a pull request. Make sure you
/// have specified only one repository name in your request, and then try again.
pub const MultipleRepositoriesInPullRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The user name is not valid because it has exceeded the character limit for
/// author names.
pub const NameLengthExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The commit cannot be created because no changes will be made to the
/// repository as a result of this commit. A commit must contain at least one
/// change.
pub const NoChangeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The maximum number of approval rule templates has been exceeded for this
/// Amazon Web Services Region.
pub const NumberOfRuleTemplatesExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The approval rule cannot be added. The pull request has the maximum number
/// of approval rules associated with it.
pub const NumberOfRulesExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The requested action is not allowed.
pub const OperationNotAllowedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The pull request has already had its approval rules set to override.
pub const OverrideAlreadySetException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// An override status is required, but no value was provided. Valid values
/// include OVERRIDE and REVOKE.
pub const OverrideStatusRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The parent commit ID is not valid because it does not exist. The specified
/// parent commit ID does not exist in the specified branch of the repository.
pub const ParentCommitDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The file could not be added because the provided parent commit ID is not the
/// current tip of the specified branch. To view the full commit ID of the
/// current head
/// of the branch, use GetBranch.
pub const ParentCommitIdOutdatedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A parent commit ID is required. To view the full commit ID of a branch in a
/// repository, use GetBranch or a Git command
/// (for example, git pull or git log).
pub const ParentCommitIdRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified path does not exist.
pub const PathDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The folderPath for a location cannot be null.
pub const PathRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The pull request status cannot be updated because it is already closed.
pub const PullRequestAlreadyClosedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The pull request cannot be merged because one or more approval rules applied
/// to the pull request have conditions that have not been met.
pub const PullRequestApprovalRulesNotSatisfiedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The approval cannot be applied because the user approving the pull request
/// matches the user who created the pull request. You cannot approve a pull
/// request that you created.
pub const PullRequestCannotBeApprovedByAuthorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The pull request ID could not be found. Make sure that you have specified
/// the correct repository name and pull request ID, and then try again.
pub const PullRequestDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A pull request ID is required, but none was provided.
pub const PullRequestIdRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A pull request status is required, but none was provided.
pub const PullRequestStatusRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The commit cannot be created because one or more files specified in the
/// commit reference both a file and a folder.
pub const PutFileEntryConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The number of reactions has been exceeded. Reactions are limited to one
/// reaction per user for each individual comment ID.
pub const ReactionLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A reaction value is required.
pub const ReactionValueRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified reference does not exist. You must provide a full commit ID.
pub const ReferenceDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A reference name is required, but none was provided.
pub const ReferenceNameRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified reference is not a supported type.
pub const ReferenceTypeNotSupportedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// USE_NEW_CONTENT was specified, but no replacement content has been provided.
pub const ReplacementContentRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A replacement type is required.
pub const ReplacementTypeRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified repository does not exist.
pub const RepositoryDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A repository resource limit was exceeded.
pub const RepositoryLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified repository name already exists.
pub const RepositoryNameExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A repository name is required, but was not specified.
pub const RepositoryNameRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// At least one repository name object is required, but was not specified.
pub const RepositoryNamesRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The repository does not contain any pull requests with that pull request ID.
/// Use GetPullRequest to verify the correct repository name for the pull
/// request ID.
pub const RepositoryNotAssociatedWithPullRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// At least one branch name is required, but was not specified in the trigger
/// configuration.
pub const RepositoryTriggerBranchNameListRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A destination ARN for the target service for the trigger is required, but
/// was not
/// specified.
pub const RepositoryTriggerDestinationArnRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// At least one event for the trigger is required, but was not specified.
pub const RepositoryTriggerEventsListRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A name for the trigger is required, but was not specified.
pub const RepositoryTriggerNameRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The list of triggers for the repository is required, but was not specified.
pub const RepositoryTriggersListRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A valid Amazon Resource Name (ARN) for an CodeCommit resource is required.
/// For a list of valid resources in CodeCommit, see
/// [CodeCommit Resources and
/// Operations](https://docs.aws.amazon.com/codecommit/latest/userguide/auth-and-access-control-iam-access-control-identity-based.html#arn-formats)
/// in the CodeCommit User Guide.
pub const ResourceArnRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The commit cannot be created because one of the changes specifies copying or
/// moving a .gitkeep file.
pub const RestrictedSourceFileException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A revision ID is required, but was not provided.
pub const RevisionIdRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The revision ID provided in the request does not match the current revision
/// ID. Use GetPullRequest to retrieve the current revision ID.
pub const RevisionNotCurrentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The file was not added or updated because the content of the file is exactly
/// the same as the content of that file in the repository and branch
/// that you specified.
pub const SameFileContentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The commit cannot be created because one or more changes in this commit
/// duplicate actions in the same file path. For example,
/// you cannot make the same delete request to the same file in the same file
/// path twice, or make a delete request and a move request to the same
/// file as part of the same commit.
pub const SamePathRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The source branch and destination branch for the pull request are the same.
/// You must
/// specify different branches for the source and destination.
pub const SourceAndDestinationAreSameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The commit cannot be created because no source files or file content have
/// been specified for the commit.
pub const SourceFileOrContentRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A list of tag keys is required. The list cannot be empty or null.
pub const TagKeysListRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The tag policy is not valid.
pub const TagPolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A map of tags is required.
pub const TagsMapRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A pull request target is required. It cannot be empty or null. A pull
/// request target must contain the full values for the repository name, source
/// branch, and destination branch for the pull request.
pub const TargetRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// An array of target objects is required. It cannot be empty or null.
pub const TargetsRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The tip of the source branch in the destination repository does not match
/// the tip of the source branch specified in your request.
/// The pull request might have been updated. Make sure that you have the latest
/// changes.
pub const TipOfSourceReferenceIsDifferentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The divergence between the tips of the provided commit specifiers is too
/// great to determine whether there might be
/// any merge conflicts. Locally compare the specifiers using `git diff` or a
/// diff tool.
pub const TipsDivergenceExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A pull request title is required. It cannot be empty or null.
pub const TitleRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The maximum number of tags for an CodeCommit resource has been exceeded.
pub const TooManyTagsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
