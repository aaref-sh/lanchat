import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

BubbleStyle me = BubbleStyle(
  margin: BubbleEdges.only(top: 10),
  alignment: Alignment.topRight,
  nip: BubbleNip.rightTop,
  elevation: 3,
  color: Color.fromRGBO(225, 255, 199, 1.0),
);
BubbleStyle me2 = BubbleStyle(
  margin: BubbleEdges.only(top: 2),
  alignment: Alignment.topRight,
  elevation: 3,
  nip: BubbleNip.no,
  color: Color.fromRGBO(225, 255, 199, 1.0),
);
BubbleStyle he = BubbleStyle(
  margin: BubbleEdges.only(top: 10),
  alignment: Alignment.topLeft,
  elevation: 3,
  nip: BubbleNip.leftTop,
);
BubbleStyle he2 = BubbleStyle(
  margin: BubbleEdges.only(top: 2),
  alignment: Alignment.topLeft,
  elevation: 3,
  nip: BubbleNip.no,
);
BubbleStyle heading = BubbleStyle(
  alignment: Alignment.center,
  color: Color.fromARGB(255, 212, 234, 244),
  elevation: 2,
  margin: BubbleEdges.only(top: 8.0),
);
TextAlign ta(String messag) {
  return ar(messag) ? TextAlign.right : TextAlign.left;
}

TextDirection td(String message) {
  return ar(message) ? TextDirection.rtl : TextDirection.ltr;
}

bool ar(String text) {
  if (text == '') return false;
  if (text.codeUnitAt(0) >= 0x600 && text.codeUnitAt(0) <= 0x6ff) return true;
  if (text.codeUnitAt(0) >= 0x750 && text.codeUnitAt(0) <= 0x77f) return true;
  if (text.codeUnitAt(0) >= 0xfb50 && text.codeUnitAt(0) <= 0xfc3f) return true;
  if (text.codeUnitAt(0) >= 0xfe70 && text.codeUnitAt(0) <= 0xfefc) return true;
  return false;
}

List<dynamic> tabsemoji = [
  ["😀","😁","😂","🤣","😃","😄","😅","😆","😉","😊","😋","😎","😍","😘","🥰","😗","😙","😚","☺","🙂","🤗","🤩","🤔","🤨","😐","😑","😶","🙄","😏","😣","😥","😮","🤐","😯","😪","😫","🥱","😴","😌","😛","😜","😝","🤤","😒","😓","😔","😕","🙃","🤑","😲","☹","🙁","😖","😞","😟","😤","😢","😭","😦","😧","😨","😩","🤯","😬","😰","😱","🥵","🥶","😳","🤪","😵","🥴","😠","😡","🤬","😷","🤒","🤕","🤢","🤮","🤧","😇","🥳","🥺","🤠","🤡","🤥","🤫","🤭","🧐","🤓","😈","👿","👹","👺","💪","🦵","🦶","👂","🦻","👃","🤏","👈","👉","☝","👆","👇","✌","🤞","🖖","🤘","🤙","🖐","✋","👌","👍","👎","✊","👊","🤛","🤜","🤚","👋","🤟","✍","👏","👐","🙌","🤲","🙏","🤝","💅","👩","👨","🧑","👧","👦","🧒","👶","👵","👴","🧓","👩‍🦰","👨‍🦰","👩‍🦱","👨‍🦱","👩‍🦲","👨‍🦲","👩‍🦳","👨‍🦳","👱‍♀️","👱‍♂️","👸","🤴","👳‍♀️","👳‍♂️","👲","🧔","👼","🤶","🎅","👮‍♀️","👮‍♂️","🕵️‍♀️","🕵️‍♂️","💂‍♀️","💂‍♂️","👷‍♀️","👷‍♂️","👩‍⚕️","👨‍⚕️","👩‍🎓","👨‍🎓","👩‍🏫","👨‍🏫","👩‍⚖️","👨‍⚖️","👩‍🌾","👨‍🌾","👩‍🍳","👨‍🍳","👩‍🔧","👨‍🔧","👩‍🏭","👨‍🏭","👩‍💼","👨‍💼","👩‍🔬","👨‍🔬","👩‍💻","👨‍💻","👩‍🎤","👨‍🎤","👩‍🎨","👨‍🎨","👩‍✈️","👨‍✈️","👩‍🚀","👨‍🚀","👩‍🚒","👨‍🚒","🧕","👰","🤵","🤱","🤰","🦸‍♀️","🦸‍♂️","🦹‍♀️","🦹‍♂️","🧙‍♀️","🧙‍♂️","🧚‍♀️","🧚‍♂️","🧛‍♀️","🧛‍♂️","🧜‍♀️","🧜‍♂️","🧝‍♀️","🧝‍♂️","🧟‍♀️","🧟‍♂️","🙍‍♀️","🙍‍♂️","🙎‍♀️","🙎‍♂️","🙅‍♀️","🙅‍♂️","🙆‍♀️","🙆‍♂️","🧏‍♀️","🧏‍♂️","💁‍♀️","💁‍♂️","🙋‍♀️","🙋‍♂️","🙇‍♀️","🙇‍♂️","🤦‍♀️","🤦‍♂️","🤷‍♀️","🤷‍♂️","💆‍♀️","💆‍♂️","💇‍♀️","💇‍♂️","🧖‍♀️","🧖‍♂️","🤹‍♀️","🤹‍♂️","👩‍🦽","👨‍🦽","👩‍🦼","👨‍🦼","👩‍🦯","👨‍🦯","🧎‍♀️","🧎‍♂️","🧍‍♀️","🧍‍♂️","🚶‍♀️","🚶‍♂️","🏃‍♀️","🏃‍♂️","💃","🕺","🧗‍♀️","🧗‍♂️","🧘‍♀️","🧘‍♂️","🛀","🛌","🕴","🏇","🏂","🏌️‍♀️","🏌️‍♂️","🏄‍♀️","🏄‍♂️","🚣‍♀️","🚣‍♂️","🏊‍♀️","🏊‍♀️","🏊‍♂️","🤽‍♀️","🤽‍♂️","🤾‍♀️","🤾‍♂️","⛹️‍♀️","⛹️‍♂️","🏋️‍♀️","🏋️‍♂️","🚴‍♀️","🚴‍♂️","🚵‍♀️","🚵‍♂️","🤸‍♀️","🤸‍♂️","🤳","💀","☠","👻","👽","👾","🤖","💩","🧞‍♀️","🧞‍♂️","🗣","👤","👥","👁","👀","🦴","🦷","👅","👄","🧠","🦾","🦿","👣","🤺","⛷","🤼‍♂️","🤼‍♀️","👯‍♂️","👯‍♀️","💑","👩‍❤️‍👩","👨‍❤️‍👨","👩‍❤️‍💋‍👩","💏","👨‍❤️‍💋‍👨","👪","👪","👨‍👩‍👦","👨‍👩‍👧","👨‍👩‍👧‍👦","👨‍👩‍👦‍👦","👨‍👩‍👧‍👧","👨‍👨‍👦","👨‍👨‍👧","👨‍👨‍👧‍👦","👨‍👨‍👦‍👦","👨‍👨‍👧‍👧","👩‍👩‍👦","👩‍👩‍👧","👩‍👩‍👧‍👦","👩‍👩‍👦‍👦","👩‍👩‍👧‍👧","👩‍👦","👩‍👧","👩‍👧‍👦","👩‍👦‍👦","👩‍👧‍👧","👨‍👦","👨‍👧","👨‍👧‍👦","👨‍👦‍👦","👨‍👧‍👧","👭","👩🏻‍🤝‍👩🏻","👩🏼‍🤝‍👩🏻","👩🏼‍🤝‍👩🏼","👩🏽‍🤝‍👩🏻","👩🏽‍🤝‍👩🏼","👩🏽‍🤝‍👩🏽","👩🏾‍🤝‍👩🏻","👩🏾‍🤝‍👩🏼","👩🏾‍🤝‍👩🏽","👩🏾‍🤝‍👩🏾","👩🏿‍🤝‍👩🏻","👩🏿‍🤝‍👩🏼","👩🏿‍🤝‍👩🏽","👩🏿‍🤝‍👩🏾","👩🏿‍🤝‍👩🏿","👫","👩🏻‍🤝‍🧑🏻","👩🏻‍🤝‍🧑🏼","👩🏻‍🤝‍🧑🏽","👩🏻‍🤝‍🧑🏾","👩🏻‍🤝‍🧑🏾","👩🏻‍🤝‍🧑🏿","👩🏼‍🤝‍🧑🏽","👩🏼‍🤝‍🧑🏾","👩🏼‍🤝‍🧑🏿","👩🏽‍🤝‍🧑🏻","👩🏽‍🤝‍🧑🏼","👩🏽‍🤝‍🧑🏽","👩🏽‍🤝‍🧑🏾","👩🏽‍🤝‍🧑🏿","👩🏾‍🤝‍🧑🏻","👩🏾‍🤝‍🧑🏼","👩🏾‍🤝‍🧑🏽","👩🏾‍🤝‍🧑🏾","👩🏾‍🤝‍🧑🏿","👩🏿‍🤝‍🧑🏻","👩🏿‍🤝‍🧑🏼","👩🏿‍🤝‍🧑🏽","👩🏿‍🤝‍🧑🏾","👩🏿‍🤝‍🧑🏿","👬","👨🏻‍🤝‍👨🏻","👨🏼‍🤝‍👨🏻","👨🏼‍🤝‍👨🏼","👨🏽‍🤝‍👨🏻","👨🏽‍🤝‍👨🏼","👨🏽‍🤝‍👨🏽","👨🏾‍🤝‍👨🏻","👨🏾‍🤝‍👨🏼","👨🏾‍🤝‍👨🏽","👨🏾‍🤝‍👨🏾","👨🏿‍🤝‍👨🏻","👨🏿‍🤝‍👨🏼","👨🏿‍🤝‍👨🏽","👨🏿‍🤝‍👨🏾","👨🏿‍🤝‍👨🏿",],
  ["😺","😸","😹","😻","😼","😽","🙀","😿","😾","🐱‍👤","🐱‍🏍","🐱‍💻","🐱‍🐉","🐱‍👓","🐱‍🚀","🙈","🙉","🙊","🐵","🐶","🐺","🐱","🦁","🐯","🦒","🦊","🦝","🐮","🐷","🐗","🐭","🐹","🐰","🐻","🐨","🐼","🐸","🦓","🐴","🦄","🐔","🐲","🐽","🐾","🐒","🦍","🦧","🦮","🐕‍🦺","🐩","🐕","🐈","🐅","🐆","🐎","🦌","🦏","🦛","🐂","🐃","🐄","🐖","🐏","🐑","🐐","🐪","🐫","🦙","🦘","🦥","🦨","🦡","🐘","🐁","🐀","🦔","🐇","🐿","🦎","🐊","🐢","🐍","🐉","🦕","🦖","🦦","🦈","🐬","🐳","🐋","🐟","🐠","🐡","🦐","🦑","🐙","🦞","🦀","🐚","🦆","🐓","🦃","🦅","🕊","🦢","🦜","🦩","🦚","🦉","🐦","🐧","🐥","🐤","🐣","🦇","🦋","🐌","🐛","🦟","🦗","🐜","🐝","🐞","🦂","🕷","🕸","🦠",],
  ["🎈","🎆","🎇","🧨","✨","🎉","🎊","🎃","🎄","🎋","🎍","🎎","🎏","🎐","🎑","🧧","🎀","🎁","🎗","🎞","🎟","🎫","🎠","🎡","🎢","🎪","🎭","🖼","🎨","🧵","🧶","🛒","👓","🕶","🦺","🥽","🥼","🧥","👔","👕","👖","🩳","🧣","🧤","🧦","👗","🥻","👘","👚","🩲","🩱","👙","👛","👜","👝","🛍","🎒","👞","👟","🥾","🥿","👠","👡","👢","🩰","👑","🧢","⛑","👒","🎩","🎓","💋","💄","💍","💎","⚽","⚾","🥎","🏀","🏐","🏈","🏉","🎱","🎳","🥌","⛳","⛸","🎣","🤿","🎽","🛶","🎿","🛷","🥅","🏒","🥍","🏏","🏑","🏑","🏓","🏸","🎾","🥏","🪁","🎯","🥊","🥋","🥇","🥈","🥉","🏅","🎖","🏆","🎮","🕹","🎰","🎲","🔮","🧿","🧩","🧸","🪀","🎴","🃏","🀄","♟","♠","♣","♥","♦","♦","🔈","🔉","🔊","📢","📣","🔔","🎼","🎵","🎶","🎙","🎤","🎤","🎚","🎛","🎧","📯","🥁","🎷","🎺","🎸","🪕","🎻","🎹","📻","🔒","🔓","🔏","🔐","🔑","🗝","🪓","🔨","⛏","⚒","🛠","🔧","🔩","🧱","⚙","🗜","🛢","⚗","🧪","🧫","🧬","🩺","💉","🩸","🩹","💊","🔬","🔭","⚖","📿","🔗","⛓","🧰","🧲","🦯","🛡","🏹","🗡","⚔","🔪","💣","🔫","☎","📞","📟","📠","📱","📲","📳","📴","🚬","⚰","⚱","🗿","🔋","🔌","💻","🖥","🖨","⌨","🖱","🖲","💽","💾","💿","📀","🧮","🎥","🎬","📽","📡","📺","📷","📸","📹","📼","🔍","🔎","🕯","🪔","💡","🔦","🏮","📔","📕","📖","📗","📘","📙","📚","📓","📒","📃","📜","📄","📑","📰","🗞","🔖","🏷","💰","💴","💵","💶","💷","💸","💳","🧾","🏧","✉","📧","📨","📩","📤","📥","📦","📫","📪","📬","📭","📮","🗳","✏","✒","🖋","🖊","🖌","🖍","📝","🗒","💼","📁","📂","🗂","📅","📆","🗓","📇","📈","📉","📊","📋","📌","📍","📎","🖇","📏","📐","✂","🗃","🗄","🗑","⌛","⏳","⌚","⏰","⏱","⏲","🕰",],
  ["🍕","🍔","🍟","🌭","🍿","🧂","🥓","🥚","🍳","🧇","🥞","🧈","🍞","🥐","🥨","🥯","🥖","🧀","🥗","🥙","🥪","🌮","🌯","🥫","🍖","🍗","🥩","🍠","🥟","🥠","🥡","🍱","🍘","🍙","🍚","🍛","🍜","🦪","🍣","🍤","🍥","🥮","🍢","🧆","🥘","🍲","🍝","🥣","🥧","🍦" ,"🍧","🍨","🍩","🍪","🎂","🍰","🧁","🍫" ,"🍬","🍭","🍡","🍮","🍯","🍼 ","🥛","🧃","☕","🍵","🧉","🍶","🍾","🍷" ,"🍸","🍹","🍺","🍻","🥂","🥃","🧊","🥤","🥢","🍽","🍴" ,"🥄","🏺","🥝","🥥","🍇","🍈","🍉","🍊","🍋","🍌","🍍","🥭","🍎","🍏","🍐","🍑","🍒","🍓","🍅","🍆","🌽","🌶","🍄","🥑","🥒","🥬","🥦","🥔","🧄","🧅","🥕","🌰","🥜","💐","🌸","🏵","🌹" ,"🌺","🌻","🌼","🌷","🥀","☘","🌱","🌲","🌳","🌴","🌵","🌾","🌿","🍀","🍁","🍂","🍃",],
  ["🚗","🚓","🚕","🛺","🚙","🚌","🚐","🚎","🚑","🚒","🚚","🚛","🚜","🚘","🚔","🚖","🚍","🦽","🦼","🛹","🚲","🛴","🛵","🏍","🏎","🚄","🚅","🚈","🚝","🚞","🚃","🚋","🚆","🚉","🚊","🚇","🚟","🚠","🚡","🚂","🛩","🪂","✈","🛫","🛬","💺","🚁","🚀","🛸","🛰","⛵","🚤","🛥","⛴","🛳","🚢","⚓","🚏","⛽","🚨","🚥","🚦","🚧","🏁","🏳","🌈","🏳","🏴","🏴","☠","🚩","🌌","🪐","🌍","🌎","🌏","🗺","🧭","🏔","⛰","🌋","🗻","🛤","🏕","🏞","🛣","🏖","🏜","🏝","🏟","🏛","🏗","🏘","🏙","🏚","🏠","🏡","⛪","🕋","🕌","🛕","🕍","⛩","🏢","🏣","🏤","🏥","🏦","🏨","🏩","🏪","🏫","🏬","🏭","🏯","🏰","💒","🗼","🌉","🗽","🗾","🎌","⛲","⛺","🌁","🌃","🌄","🌅","🌆","🌇","♨","💈","🛎","🧳","🪑 ","🚪","🛏","🛋","🚽","🧻","🚿","🛁","🧼","🧽","🧴 ","🪒","🧷","🧹","🧺","🧯","☁","⛅","⛈","🌤","🌥","🌦","🌧","🌨","🌩","🌪","🌫","🌝","🌑","🌒","🌓","🌔","🌕","🌖","🌗","🌘","🌙","🌚","🌛","🌜","☀","🌞","⭐","🌟","🌠","☄","🌡 ","🌬","🌀","🌈","🌂","☂","☔","⛱","⚡","❄","☃","⛄","🔥","💧","🌊",],
  ["❤","🧡","💛","💚","💙","💜","🤎","🖤","🤍","💔","❣","💕","💞","💓","💗","💖","💘","💝","💟","💌","💢","💥","💤","💦","💨","💫","🕳","☮","✝","☪","🕉","☸","✡","🔯","🕎","☯","☦","🛐","⛎","♈","♉","♊","♋","♌","♍","♎","♏","♐","♑","♒","♓","🆔","⚕","♾","⚛","🈳","🈹","🈶","🈚","🈸","🈺","🈷","✴","🆚","🉑","💮","🉐","㊙","㊗","🈴","🈵","🈲","🚼","🅰","🅱","🆎","🆑","🅾","🆘","⛔","🛑","📛","❌","⭕ ","🚫","🔇","🔕","🚭","🚷","🚯","🚳","🚱","🔞","📵","❗ ","❕ ","❓ ","❔ ","‼ ","⁉ ","💯","🔅","🔆","🔱","⚜","〽","☢","☣","⚠","🚸","🔰 ","♻","🈯","💹","❇","✳","❎","✅","💠","🌐","Ⓜ ","🈂","➿","🛂","🛃","🛄","🛅","♿","🚾","🅿","🚰","🚹","🚺","🚻","🚮","📶","🈁","🆖","🆗","🆙","🆒","🆕","🆓","▶ ","⏸","⏯","⏹","⏺","⏭","⏮","⏩","⏪","🔀","🔁","🔂","◀ ","🔼","⏫","🔽","⏬","⏏","🎦","➡","⬅ ","⬆ ","⬇ ","↗ ","↘ ","↙ ","↖ ","↕ ","↔ ","🔄","↪ ","↩ ","⤴ ","⤵ ","ℹ","🔤","🔡","🔠","🔣","🔃","🔛","🔝","🔜","☑","🔚","🔙","〰","➰","✔","💲 ","💱","➕","➖","✖","➗","© ","® ","™ ","🔘","🔴","🟠","🟡","🟢","🔵","🟣","🟤","⚫","⚪","🟥","🟧","🟨","🟩","🟦","🟪","🟫","⬛ ","⬜ ","◼ ","◻ ","◾ ","◽ ","▪ ","▫ ","🔶","🔸","🔷","🔹","🔺","🔻","🔲","🔳","💭","🗯","💬","🗨","👁","🗨","🕐","🕑","🕒","🕓","🕔","🕕","🕖","🕗","🕘","🕙","🕚","🕛","🕜","🕝","🕞","🕟","🕠","🕡","🕢","🕣","🕤","🕥","🕦","🕧",]
];

List<String> tabsname = ["🙂", "🐼", "🎈", "🍕", "🚗", "❤"];
