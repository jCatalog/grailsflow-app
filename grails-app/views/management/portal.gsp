<!--
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
-->

<html>
  <head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
   <meta name="layout" content="grailsflow"/>

   <gf:messageBundle bundle="application" var="application_bundle"/>
   <gf:messageBundle bundle="menu" var="menu_bundle"/>
   <gf:messageBundle bundle="grailsflow.processTypes" var="process_types"/>
   <gf:messageBundle bundle="grailsflow.worklist" var="worklist"/>
   <gf:messageBundle bundle="grailsflow.common" var="common"/>

   <title>${application_bundle['label.appTitle']}</title>
  </head>

  <body>
  <div name=content>
    <b class="header">${menu_bundle['menu.grailsManagement']}</b><br/>
    <p>If you use the Grailsflow demo application for the first time, please read the
       <a href="http://www.jcatalog.com/oss/grailsflow/firstSteps.html">first steps</a>
       document.
    </p>
    <p>You find more information about the main ideas behind Grailsflow
       <a href="http://www.jcatalog.com/oss/grailsflow/index.html">here</a>.
    </p>
    <p>Thank you for trying Grailsflow. We appreciate your feedback. Send us an
       <a href="http://www.jcatalog.com/oss/grailsflow/contact.html">email</a>.
    </p>

    <h2 class="headline">${process_types['grailsflow.title.startProcess']}</h2>
    <table class="standard" width="100%">
      <thead>
        <tr>
          <th>${process_types['grailsflow.label.processType']}</th>
          <th width="70%">${process_types['grailsflow.label.description']}</th>
          <th>${process_types['grailsflow.label.operation']}</th>
        </tr>
      </thead>
      <tbody>
            <g:each in="${processClasses}" var="item" status="i">
              <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                <td><gf:translatedValue translations="${item.label}" default="${item.processType}"/></td>
                <td><gf:translatedValue translations="${item.description}" default=""/></td>
                <td>
                  <g:link action="startProcess" controller="processManagement" id="${item.processType}" title="${common['grailsflow.command.start']}">${common['grailsflow.command.start']}</g:link>
                </td>
              </tr>
            </g:each>
      </tbody>
    </table>    
    <p class="title">
      <img src="${g.resource(dir:'images/general',file:'warning16.gif')}"/>&nbsp;
      ${processClasses.size()}&nbsp;${application_bundle['label.of']}&nbsp;${typesTotal}&nbsp;
      ${application_bundle['message.processTypes.listed']}

      <g:if test="${processClasses.size() < typesTotal}">
        ${application_bundle['message.processTypes.reviewAll']}&nbsp;
        <g:link action="showTypes" controller="process">
          ${menu_bundle['menu.startProcesType']}          
        </g:link>.
      </g:if>
    </p><br/>
    <h2 class="headline">${worklist['grailsflow.title.worklist']}</h2>
    <table width="100%" class="standard">
             <thead>
               <tr>
                  <th>${worklist['grailsflow.label.nodeID']}</th>
                  <th>${worklist['grailsflow.label.processType']}</th>
                  <th>${worklist['grailsflow.label.description']}</th>
                  <th>${worklist['grailsflow.label.status']}</th>
                  <th>${worklist['grailsflow.label.caller']}</th>
                  <th>${worklist['grailsflow.label.startedOn']}</th>
                  <th>${worklist['grailsflow.label.dueOn']}</th>
                </tr>
             </thead>
             <tbody>
               <g:each in="${processNodeList.keySet()}" var="node">
                    <tr>
                       <td><g:if test="${processNodeList[node]}">
                             <g:link id="${node.id}" action="showNodeDetails" controller="process">
                               ${node.nodeID}
                             </g:link>
                           </g:if>
                           <g:else>
                             ${node.nodeID}
                           </g:else>
                       </td>
                       <td>${node.process ? node.process.type: ''}</td>
                       <td>${node.description}</td>
                       <td>${node.status?.statusID}</td>
                       <td>${node.caller}</td>
                       <td><gf:displayDateTime value="${node.startedOn}"/></td>
                       <td><gf:displayDateTime value="${node.dueOn}"/></td>
                    </tr>
               </g:each>
             </tbody>
    </table>
    <div class="paginateButtons">
      <g:paginate total="${worklistTotal}" action="portal"/>
    </div>

  </div>

  </body>
</html>
