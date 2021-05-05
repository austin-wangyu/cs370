!function(l){"use strict";var t,n,e,r,a,o=function(t){var n=t,e=function(){return n};return{get:e,set:function(t){n=t},clone:function(){return o(e())}}},i=tinymce.util.Tools.resolve("tinymce.PluginManager"),f=function(t){return function(){return t}},u=f(!1),s=f(!0),c=u,d=s,g=function(){return m},m=(r={fold:function(t,n){return t()},is:c,isSome:c,isNone:d,getOr:e=function(t){return t},getOrThunk:n=function(t){return t()},getOrDie:function(t){throw new Error(t||"error: getOrDie called on none.")},getOrNull:function(){return null},getOrUndefined:function(){return undefined},or:e,orThunk:n,map:g,ap:g,each:function(){},bind:g,flatten:g,exists:c,forall:d,filter:g,equals:t=function(t){return t.isNone()},equals_:t,toArray:function(){return[]},toString:f("none()")},Object.freeze&&Object.freeze(r),r),h=function(e){var t=function(){return e},n=function(){return a},r=function(t){return t(e)},a={fold:function(t,n){return n(e)},is:function(t){return e===t},isSome:d,isNone:c,getOr:t,getOrThunk:t,getOrDie:t,getOrNull:t,getOrUndefined:t,or:n,orThunk:n,map:function(t){return h(t(e))},ap:function(t){return t.fold(g,function(t){return h(t(e))})},each:function(t){t(e)},bind:r,flatten:t,exists:r,forall:r,filter:function(t){return t(e)?a:m},equals:function(t){return t.is(e)},equals_:function(t,n){return t.fold(c,function(t){return n(e,t)})},toArray:function(){return[e]},toString:function(){return"some("+e+")"}};return a},p={some:h,none:g,from:function(t){return null===t||t===undefined?m:h(t)}},v=(a="function",function(t){return function(t){if(null===t)return"null";var n=typeof t;return"object"===n&&Array.prototype.isPrototypeOf(t)?"array":"object"===n&&String.prototype.isPrototypeOf(t)?"string":n}(t)===a}),O=function(t,n){for(var e=[],r=0,a=t.length;r<a;r++){var o=t[r];n(o,r,t)&&e.push(o)}return e},y=Array.prototype.slice,P=(v(Array.from)&&Array.from,Object.hasOwnProperty),x=function(t,n){return P.call(t,n)},T=function(t){return x(t,"start")&&x(t,"end")},b=function(t){return!x(t,"end")&&!x(t,"replacement")},k=function(t){return x(t,"replacement")},C=function(t){return n=t,e=function(t,n){return t.start.length===n.start.length?0:t.start.length>n.start.length?-1:1},(r=y.call(n,0)).sort(e),r;var n,e,r},D=function(t){return{inlinePatterns:C(O(t,T)),blockPatterns:C(O(t,b)),replacementPatterns:O(t,k)}},S=function(n){return{setPatterns:function(t){n.set(D(t))},getPatterns:function(){return n.get().inlinePatterns.concat(n.get().blockPatterns,n.get().replacementPatterns)}}},A=[{start:"*",end:"*",format:"italic"},{start:"**",end:"**",format:"bold"},{start:"***",end:"***",format:["bold","italic"]},{start:"#",format:"h1"},{start:"##",format:"h2"},{start:"###",format:"h3"},{start:"####",format:"h4"},{start:"#####",format:"h5"},{start:"######",format:"h6"},{start:"1. ",cmd:"InsertOrderedList"},{start:"* ",cmd:"InsertUnorderedList"},{start:"- ",cmd:"InsertUnorderedList"}],N=function(t){var n,e,r=(n=t,e="textpattern_patterns",x(n,e)?p.from(n[e]):p.none()).getOr(A);return D(r)},R=tinymce.util.Tools.resolve("tinymce.util.Delay"),w=tinymce.util.Tools.resolve("tinymce.util.VK"),I=tinymce.util.Tools.resolve("tinymce.dom.TreeWalker"),j=tinymce.util.Tools.resolve("tinymce.util.Tools"),E=function(t,n){for(var e=0;e<t.length;e++){var r=t[e];if(0===n.indexOf(r.start)&&(!r.end||n.lastIndexOf(r.end)===n.length-r.end.length))return r}},q=function(t,n,e){if(!1!==n.collapsed){var r=n.startContainer,a=r.data,o=!0===e?1:0;if(3===r.nodeType){var i=function(t,n,e,r){var a,o,i,f,u,s;for(o=0;o<t.length;o++)if((a=t[o]).end!==undefined&&(f=a,u=e,s=r,n.substr(u-f.end.length-s,f.end.length)===f.end)&&0<e-r-(i=a).end.length-i.start.length)return a}(t,a,n.startOffset,o);if(i!==undefined){var f=a.lastIndexOf(i.end,n.startOffset-o),u=a.lastIndexOf(i.start,f-i.end.length);if(f=a.indexOf(i.end,u+i.start.length),-1!==u){var s=l.document.createRange();s.setStart(r,u),s.setEnd(r,f+i.end.length);var c=E(t,s.toString());if(!(i===undefined||c!==i||r.data.length<=i.start.length+i.end.length))return{pattern:i,startOffset:u,endOffset:f}}}}}},L=function(t){return t&&3===t.nodeType},M=function(t,n,e){var r=t.dom.createRng();r.setStart(n,e),r.setEnd(n,e),t.selection.setRng(r)},U=function(n,t,e){var r=n.selection.getRng();return p.from(q(t,r,e)).map(function(t){return function(a,o,i,f){var u=j.isArray(i.pattern.format)?i.pattern.format:[i.pattern.format];if(0!==j.grep(u,function(t){var n=a.formatter.get(t);return n&&n[0].inline}).length)return a.undoManager.transact(function(){var t,n,e,r;t=o,n=i.pattern,e=i.endOffset,r=i.startOffset,(t=0<r?t.splitText(r):t).splitText(e-r+n.end.length),t.deleteData(0,n.start.length),t.deleteData(t.data.length-n.end.length,n.end.length),o=t,f&&a.selection.setCursorLocation(o.nextSibling,1),u.forEach(function(t){a.formatter.apply(t,{},o)})}),o}(n,r.startContainer,t,e)})},_=function(s,t,c){var n=s.selection.getRng(),l=n.startContainer;n.collapsed&&L(l)&&function(t,n,e){for(var r=0;r<t.length;r++){var a=e.lastIndexOf(t[r].start,n);if(-1!==a)return p.some({pattern:t[r],startOffset:a})}return p.none()}(t,n.startOffset,l.data).each(function(t){var n,e,r,a,o,i,f,u=c?p.some((n=l,r=(e=t).startOffset+e.pattern.start.length,a=n.data.slice(r,r+1),n.deleteData(r,1),a)):p.none();o=s,f=t,(i=l).deleteData(f.startOffset,f.pattern.start.length),o.insertContent(f.pattern.replacement),p.from(i.nextSibling).filter(L).each(function(t){t.insertData(0,i.data),o.dom.remove(i)}),u.each(function(t){return function(t,n){var e=t.selection.getRng(),r=e.startContainer;if(L(r)){var a=e.startOffset;r.insertData(a,n),M(t,r,a+n.length)}else{var o=t.dom.doc.createTextNode(n);e.insertNode(o),M(t,o,o.length)}}(s,t)})})},z=function(t,n,e){for(var r=0;r<t.length;r++)if(e(t[r],n))return!0},K=function(t,n){var e,r,a,o;e=t,r=n.replacementPatterns,_(e,r,!1),a=t,o=n.inlinePatterns,U(a,o,!1).each(function(t){M(a,t,t.data.length)}),function(t,n){var e,r,a,o,i,f,u,s,c,l,d;if(e=t.selection,r=t.dom,e.isCollapsed()&&(u=r.getParent(e.getStart(),"p"))){for(c=new I(u,u);i=c.next();)if(L(i)){o=i;break}if(o){if(!(s=E(n,o.data)))return;if(a=(l=e.getRng(!0)).startContainer,d=l.startOffset,o===a&&(d=Math.max(0,d-s.start.length)),j.trim(o.data).length===s.start.length)return;s.format&&(f=t.formatter.get(s.format))&&f[0].block&&(o.deleteData(0,s.start.length),t.formatter.apply(s.format,{},o),l.setStart(a,d),l.collapse(!0),e.setRng(l)),s.cmd&&t.undoManager.transact(function(){o.deleteData(0,s.start.length),t.execCommand(s.cmd)})}}}(t,n.blockPatterns)},V=function(t,n){var e,r,a,o;e=t,r=n.replacementPatterns,_(e,r,!0),a=t,o=n.inlinePatterns,U(a,o,!0).each(function(t){var n=t.data.slice(-1);if(/[\u00a0 ]/.test(n)){t.deleteData(t.data.length-1,1);var e=a.dom.doc.createTextNode(n);a.dom.insertAfter(e,t.parentNode),M(a,e,1)}})},W=function(t,n){return z(t,n,function(t,n){return t.charCodeAt(0)===n.charCode})},B=function(t,n){return z(t,n,function(t,n){return t===n.keyCode&&!1===w.modifierPressed(n)})},F=function(n,e){var r=[",",".",";",":","!","?"],a=[32];n.on("keydown",function(t){13!==t.keyCode||w.modifierPressed(t)||K(n,e.get())},!0),n.on("keyup",function(t){B(a,t)&&V(n,e.get())}),n.on("keypress",function(t){W(r,t)&&R.setEditorTimeout(n,function(){V(n,e.get())})})};i.add("textpattern",function(t){var n=o(N(t.settings));return F(t,n),S(n)})}(window);
