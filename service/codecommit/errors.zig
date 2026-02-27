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

pub const ActorDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ApprovalRuleContentRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ApprovalRuleDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ApprovalRuleNameAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ApprovalRuleNameRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ApprovalRuleTemplateContentRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ApprovalRuleTemplateDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ApprovalRuleTemplateInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ApprovalRuleTemplateNameAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ApprovalRuleTemplateNameRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ApprovalStateRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AuthorDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BeforeCommitIdAndAfterCommitIdAreSameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BlobIdDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BlobIdRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BranchDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BranchNameExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BranchNameIsTagNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BranchNameRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CannotDeleteApprovalRuleFromTemplateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CannotModifyApprovalRuleFromTemplateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ClientRequestTokenRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CommentContentRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CommentContentSizeLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CommentDeletedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CommentDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CommentIdRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CommentNotCreatedByCallerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CommitDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CommitIdDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CommitIdRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CommitIdsLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CommitIdsListRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CommitMessageLengthExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CommitRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConcurrentReferenceUpdateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DefaultBranchCannotBeDeletedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DirectoryNameConflictsWithFileNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EncryptionIntegrityChecksFailedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EncryptionKeyAccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EncryptionKeyDisabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EncryptionKeyInvalidIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EncryptionKeyInvalidUsageException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EncryptionKeyNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EncryptionKeyRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EncryptionKeyUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FileContentAndSourceFileSpecifiedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FileContentRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FileContentSizeLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FileDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FileEntryRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FileModeRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FileNameConflictsWithDirectoryNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FilePathConflictsWithSubmodulePathException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FileTooLargeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FolderContentSizeLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FolderDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IdempotencyParameterMismatchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidActorArnException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidApprovalRuleContentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidApprovalRuleNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidApprovalRuleTemplateContentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidApprovalRuleTemplateDescriptionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidApprovalRuleTemplateNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidApprovalStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidAuthorArnException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidBlobIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidBranchNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidClientRequestTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidCommentIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidCommitException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidCommitIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidConflictDetailLevelException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidConflictResolutionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidConflictResolutionStrategyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidContinuationTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDeletionParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDescriptionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDestinationCommitSpecifierException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidEmailException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidFileLocationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidFileModeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidFilePositionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidMaxConflictFilesException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidMaxMergeHunksException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidMaxResultsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidMergeOptionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidOrderException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidOverrideStatusException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParentCommitIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidPathException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidPullRequestEventTypeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidPullRequestIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidPullRequestStatusException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidPullRequestStatusUpdateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidReactionUserArnException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidReactionValueException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidReferenceNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRelativeFileVersionEnumException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidReplacementContentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidReplacementTypeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRepositoryDescriptionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRepositoryNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRepositoryTriggerBranchNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRepositoryTriggerCustomDataException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRepositoryTriggerDestinationArnException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRepositoryTriggerEventsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRepositoryTriggerNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRepositoryTriggerRegionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidResourceArnException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRevisionIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRuleContentSha256Exception = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSortByException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSourceCommitSpecifierException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSystemTagUsageException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTagKeysListException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTagsMapException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTargetBranchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTargetException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTargetsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTitleException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ManualMergeRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MaximumBranchesExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MaximumConflictResolutionEntriesExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MaximumFileContentToLoadExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MaximumFileEntriesExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MaximumItemsToCompareExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MaximumNumberOfApprovalsExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MaximumOpenPullRequestsExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MaximumRepositoryNamesExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MaximumRepositoryTriggersExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MaximumRuleTemplatesAssociatedWithRepositoryException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MergeOptionRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MultipleConflictResolutionEntriesException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MultipleRepositoriesInPullRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NameLengthExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoChangeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NumberOfRuleTemplatesExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NumberOfRulesExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OperationNotAllowedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OverrideAlreadySetException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OverrideStatusRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ParentCommitDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ParentCommitIdOutdatedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ParentCommitIdRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PathDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PathRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PullRequestAlreadyClosedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PullRequestApprovalRulesNotSatisfiedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PullRequestCannotBeApprovedByAuthorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PullRequestDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PullRequestIdRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PullRequestStatusRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PutFileEntryConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReactionLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReactionValueRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReferenceDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReferenceNameRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReferenceTypeNotSupportedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReplacementContentRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReplacementTypeRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RepositoryDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RepositoryLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RepositoryNameExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RepositoryNameRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RepositoryNamesRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RepositoryNotAssociatedWithPullRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RepositoryTriggerBranchNameListRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RepositoryTriggerDestinationArnRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RepositoryTriggerEventsListRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RepositoryTriggerNameRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RepositoryTriggersListRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceArnRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RestrictedSourceFileException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RevisionIdRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RevisionNotCurrentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SameFileContentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SamePathRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SourceAndDestinationAreSameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SourceFileOrContentRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TagKeysListRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TagPolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TagsMapRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TargetRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TargetsRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TipOfSourceReferenceIsDifferentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TipsDivergenceExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TitleRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyTagsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
