*** Variables ***
${WORK_LOG_TEXT}=   //*[@content-desc="Work Logs"]
${ADD_BUTTON}=  ${WORK_LOG_TEXT}/following-sibling::*
${DESCRIPTION_TEXT}=  //*[contains(@text, 'Description')]
${SAVE_BUTTON}=  ${DESCRIPTION_TEXT}/following-sibling::android.widget.Button[8]