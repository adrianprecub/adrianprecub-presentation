<#import "base.ftlh" as template>

<#macro layout>
  <@template.skeleton>
    <div>
      <#nested>
    </div>
  </@template.skeleton>
</#macro>